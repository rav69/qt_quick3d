/*
 * Lightweight epoll-driven TCP server with PING/PONG heartbeat.
 * Configuration via JSON file (default: pse_config.json).
 *
 * Dependencies: cJSON.h, cJSON.c (single-file, MIT license)
 *   wget https://raw.githubusercontent.com/DaveGamble/cJSON/master/cJSON.h
 *   wget https://raw.githubusercontent.com/DaveGamble/cJSON/master/cJSON.c
 *
 * Build:
 *   gcc -O2 -Wall -Wextra -std=c11 -o pse_server pse_server.c cJSON.c -lm
 */

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <signal.h>
#include <errno.h>
#include <unistd.h>
#include <fcntl.h>
#include <time.h>
#include <sys/socket.h>
#include <sys/epoll.h>
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <arpa/inet.h>
#include "cJSON.h"

/* ==========================[ Defaults ]=============================== */

#define DEFAULT_PORT            8089
#define DEFAULT_MAX_EVENTS      1024
#define DEFAULT_HB_TIMEOUT      8
#define DEFAULT_KA_IDLE         5
#define DEFAULT_KA_INTERVAL     2
#define DEFAULT_KA_PROBES       3
#define DEFAULT_LOG_PREFIX      "[SERVER]"
#define INITIAL_CAPACITY        1024

/* ==========================[ Config Struct ]========================== */

typedef struct {
    int port;
    int max_events;
    int hb_timeout;
    int ka_idle;
    int ka_interval;
    int ka_probes;
    char log_prefix[32];
} config_t;

/* ==========================[ Types ]================================== */

typedef enum { CONNECTED, DISCONNECTED_GRACEFUL, DISCONNECTED_TIMEOUT } event_t;

typedef struct {
    int fd;
    char ip[INET_ADDRSTRLEN];
    uint16_t port;
    time_t last_seen, last_heartbeat;
    bool active;
    int prev_active, next_active;
} client_t;

typedef struct {
    int epoll_fd, server_fd;
    client_t *clients;
    size_t capacity;
    int active_head;
    config_t cfg;
    volatile sig_atomic_t running;
} server_t;

/* ==========================[ Config Parser ]========================== */

static int json_get_int(cJSON *obj, const char *key, int def) {
    cJSON *item = cJSON_GetObjectItem(obj, key);
    return (item && cJSON_IsNumber(item)) ? item->valueint : def;
}

static void json_get_string(cJSON *obj, const char *key, char *dst, size_t size, const char *def) {
    cJSON *item = cJSON_GetObjectItem(obj, key);
    if (item && cJSON_IsString(item))
        strncpy(dst, item->valuestring, size - 1);
    else
        strncpy(dst, def, size - 1);
    dst[size - 1] = '\0';
}

static bool load_config(const char *filename, config_t *cfg) {
    FILE *f = fopen(filename, "r");
    if (!f) {
        fprintf(stderr, "[WARN] Cannot open '%s', using defaults\n", filename);
        goto use_defaults;
    }
    
    fseek(f, 0, SEEK_END);
    long sz = ftell(f);
    fseek(f, 0, SEEK_SET);
    
    if (sz <= 0 || sz > 1024 * 1024) { fclose(f); goto use_defaults; }
    
    char *buf = malloc(sz + 1);
    if (!buf) { fclose(f); goto use_defaults; }
    fread(buf, 1, sz, f); buf[sz] = '\0'; fclose(f);
    
    cJSON *root = cJSON_Parse(buf);
    free(buf);
    
    if (!root) { fprintf(stderr, "[WARN] Invalid JSON, using defaults\n"); goto use_defaults; }
    
    cJSON *server = cJSON_GetObjectItem(root, "server");
    if (server) {
        cfg->port       = json_get_int(server, "port", DEFAULT_PORT);
        cfg->max_events = json_get_int(server, "max_events", DEFAULT_MAX_EVENTS);
    } else {
        cfg->port       = DEFAULT_PORT;
        cfg->max_events = DEFAULT_MAX_EVENTS;
    }
    
    cJSON *hb = cJSON_GetObjectItem(root, "heartbeat");
    cfg->hb_timeout = hb ? json_get_int(hb, "timeout_sec", DEFAULT_HB_TIMEOUT) : DEFAULT_HB_TIMEOUT;
    
    cJSON *ka = cJSON_GetObjectItem(root, "keepalive");
    if (ka) {
        cfg->ka_idle     = json_get_int(ka, "idle_sec", DEFAULT_KA_IDLE);
        cfg->ka_interval = json_get_int(ka, "interval_sec", DEFAULT_KA_INTERVAL);
        cfg->ka_probes   = json_get_int(ka, "probes", DEFAULT_KA_PROBES);
    } else {
        cfg->ka_idle     = DEFAULT_KA_IDLE;
        cfg->ka_interval = DEFAULT_KA_INTERVAL;
        cfg->ka_probes   = DEFAULT_KA_PROBES;
    }
    
    json_get_string(root, "log_prefix", cfg->log_prefix, sizeof(cfg->log_prefix), DEFAULT_LOG_PREFIX);
    
    cJSON_Delete(root);
    return true;
    
use_defaults:
    cfg->port        = DEFAULT_PORT;
    cfg->max_events  = DEFAULT_MAX_EVENTS;
    cfg->hb_timeout  = DEFAULT_HB_TIMEOUT;
    cfg->ka_idle     = DEFAULT_KA_IDLE;
    cfg->ka_interval = DEFAULT_KA_INTERVAL;
    cfg->ka_probes   = DEFAULT_KA_PROBES;
    strncpy(cfg->log_prefix, DEFAULT_LOG_PREFIX, sizeof(cfg->log_prefix) - 1);
    return false;
}

/* ==========================[ Helpers ]================================ */

static const char *evt_str(event_t e) {
    switch (e) {
        case CONNECTED:              return "CONNECTED";
        case DISCONNECTED_GRACEFUL:  return "DISCONNECTED (graceful)";
        case DISCONNECTED_TIMEOUT:   return "DISCONNECTED (timeout/dead-peer)";
        default:                     return "UNKNOWN";
    }
}

static void log_event(const server_t *s, const client_t *c, event_t e) {
    time_t now = time(NULL);
    char tb[26]; ctime_r(&now, tb); tb[24] = '\0';
    fprintf(stdout, "%s [%s] %-35s | fd=%-5d | %s:%u\n",
            s->cfg.log_prefix, tb, evt_str(e), c->fd,
            c->ip[0] ? c->ip : "?", c->port);
    fflush(stdout);
}

static void set_keepalive(int fd, const config_t *cfg) {
    int v = 1; setsockopt(fd, SOL_SOCKET, SO_KEEPALIVE, &v, sizeof(v));
    v = cfg->ka_idle;     setsockopt(fd, IPPROTO_TCP, TCP_KEEPIDLE, &v, sizeof(v));
    v = cfg->ka_interval; setsockopt(fd, IPPROTO_TCP, TCP_KEEPINTVL, &v, sizeof(v));
    v = cfg->ka_probes;   setsockopt(fd, IPPROTO_TCP, TCP_KEEPCNT, &v, sizeof(v));
}

static void epoll_add(int epfd, int fd, uint32_t events) {
    struct epoll_event ev = { .events = events, .data.fd = fd };
    epoll_ctl(epfd, EPOLL_CTL_ADD, fd, &ev);
}

/* ==========================[ Active List Ops ]======================== */

static void link_active(server_t *s, int fd) {
    client_t *c = &s->clients[fd];
    c->prev_active = -1;
    c->next_active = s->active_head;
    if (s->active_head != -1)
        s->clients[s->active_head].prev_active = fd;
    s->active_head = fd;
}

static void unlink_active(server_t *s, int fd) {
    client_t *c = &s->clients[fd];
    if (c->prev_active != -1)
        s->clients[c->prev_active].next_active = c->next_active;
    else
        s->active_head = c->next_active;
    if (c->next_active != -1)
        s->clients[c->next_active].prev_active = c->prev_active;
}

/* ==========================[ Server Init ]============================ */

static int create_server(uint16_t port) {
    int fd = socket(AF_INET, SOCK_STREAM | SOCK_NONBLOCK, 0);
    if (fd < 0) { perror("socket"); return -1; }
    
    int opt = 1;
    setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));
//    setsockopt(fd, SOL_SOCKET, SO_REUSEPORT, &opt, sizeof(opt));
    
    struct sockaddr_in a = { .sin_family = AF_INET, .sin_addr.s_addr = INADDR_ANY,
                              .sin_port = htons(port) };
    if (bind(fd, (struct sockaddr*)&a, sizeof(a)) < 0 ||
        listen(fd, SOMAXCONN) < 0) {
        perror("bind/listen"); close(fd); return -1;
    }
    return fd;
}

static void ensure_capacity(server_t *s, int fd) {
    if ((size_t)fd >= s->capacity) {
        size_t nc = fd + 256;
        client_t *tmp = realloc(s->clients, nc * sizeof(client_t));
        if (!tmp) { fprintf(stderr, "%s [FATAL] OOM\n", s->cfg.log_prefix); exit(1); }
        for (size_t i = s->capacity; i < nc; i++)
            tmp[i] = (client_t){ .fd = -1 };
        s->clients = tmp; s->capacity = nc;
    }
}

/* ==========================[ Client Management ]====================== */

static void remove_client(server_t *s, int fd, event_t reason) {
    if (fd < 0 || (size_t)fd >= s->capacity || !s->clients[fd].active) return;
    
    client_t *c = &s->clients[fd];
    log_event(s, c, reason);
    unlink_active(s, fd);
    epoll_ctl(s->epoll_fd, EPOLL_CTL_DEL, fd, NULL);
    struct linger l = { .l_onoff = 1, .l_linger = 0 };
    setsockopt(fd, SOL_SOCKET, SO_LINGER, &l, sizeof(l));
    shutdown(fd, SHUT_RDWR); close(fd);
    *c = (client_t){ .fd = -1 };
}

static void check_heartbeats(server_t *s) {
    time_t now = time(NULL);
    int fd = s->active_head;
    
    while (fd != -1) {
        client_t *c = &s->clients[fd];
        int next = c->next_active;
        
        if (c->last_heartbeat && now - c->last_heartbeat > s->cfg.hb_timeout) {
            printf("%s Heartbeat lost fd=%d (%s:%u) - removing\n",
                   s->cfg.log_prefix, c->fd, c->ip, c->port);
            epoll_ctl(s->epoll_fd, EPOLL_CTL_DEL, c->fd, NULL);
            shutdown(c->fd, SHUT_RDWR); close(c->fd);
            log_event(s, c, DISCONNECTED_TIMEOUT);
            unlink_active(s, fd);
            *c = (client_t){ .fd = -1 };
        }
        
        fd = next;
    }
}

/* ==========================[ Event Handlers ]========================= */

static void accept_client(server_t *s) {
    struct sockaddr_in addr; socklen_t len = sizeof(addr);
    int fd = accept4(s->server_fd, (struct sockaddr*)&addr, &len, SOCK_NONBLOCK);
    if (fd < 0) { if (errno != EAGAIN && errno != EWOULDBLOCK) perror("accept4"); return; }
    
    set_keepalive(fd, &s->cfg); ensure_capacity(s, fd);
    
    time_t now = time(NULL);
    s->clients[fd] = (client_t){
        .fd = fd, .active = true, .last_seen = now, .last_heartbeat = now,
        .port = ntohs(addr.sin_port)
    };
    inet_ntop(AF_INET, &addr.sin_addr, s->clients[fd].ip, INET_ADDRSTRLEN);
    
    link_active(s, fd);
    epoll_add(s->epoll_fd, fd, EPOLLIN | EPOLLRDHUP | EPOLLET);
    log_event(s, &s->clients[fd], CONNECTED);
}

static void handle_data(server_t *s, int fd) {
    client_t *c = &s->clients[fd];
    if (!c->active) return;
    
    char buf[4096]; ssize_t n, total = 0;
    
    while ((n = read(fd, buf, sizeof(buf))) > 0) {
        total += n; c->last_seen = time(NULL);
        
//        if (n == 5 && !strncmp(buf, "PING", 4)) {
        if (n == 4 && !strncmp(buf, "PING", 4)) {
            c->last_heartbeat = time(NULL);
//            write(fd, "PONG", 5);
            write(fd, "PONG", 4);
        } else {
            write(fd, buf, n);
        }
    }
    
    if (n == 0) { remove_client(s, fd, DISCONNECTED_GRACEFUL); return; }
    if (n < 0 && errno != EAGAIN && errno != EWOULDBLOCK)
        { remove_client(s, fd, DISCONNECTED_TIMEOUT); return; }
    
    if (total) printf("%s Rx %zd bytes fd=%d (%s:%u)\n",
                      s->cfg.log_prefix, total, fd, c->ip, c->port);
}

/* ==========================[ Lifecycle ]============================== */

static void cleanup(server_t *s) {
    fprintf(stdout, "\n%s Shutting down...\n", s->cfg.log_prefix);
    for (size_t i = 0; i < s->capacity; i++)
        if (s->clients[i].active) { shutdown(s->clients[i].fd, SHUT_RDWR);
                                     close(s->clients[i].fd); }
    free(s->clients);
    if (s->epoll_fd >= 0) close(s->epoll_fd);
    if (s->server_fd >= 0) close(s->server_fd);
}

static void sig_h(int sig) { (void)sig; write(STDERR_FILENO,
    "\nSignal received, draining...\n", 29); }

/* ==========================[ Main ]=================================== */

int main(int argc, char *argv[]) {
    server_t s = { .epoll_fd = -1, .server_fd = -1, .active_head = -1, .running = 1 };
    
    /* Load config */
    const char *cfg_file = (argc > 1) ? argv[1] : "server_config.json";
    bool from_file = load_config(cfg_file, &s.cfg);
    
    printf("%s Loading config from: %s (%s)\n",
           s.cfg.log_prefix, cfg_file, from_file ? "OK" : "defaults");
    printf("%s Port: %d, Heartbeat: %ds, Keepalive: %d/%d/%d, Max events: %d\n\n",
           s.cfg.log_prefix, s.cfg.port, s.cfg.hb_timeout,
           s.cfg.ka_idle, s.cfg.ka_interval, s.cfg.ka_probes, s.cfg.max_events);
    
    s.clients = calloc(INITIAL_CAPACITY, sizeof(client_t));
    if (!s.clients) { perror("calloc"); return 1; }
    s.capacity = INITIAL_CAPACITY;
    for (size_t i = 0; i < s.capacity; i++) s.clients[i].fd = -1;
    
    struct sigaction sa = { .sa_handler = sig_h };
    sigemptyset(&sa.sa_mask);
    sigaction(SIGINT, &sa, NULL); sigaction(SIGTERM, &sa, NULL);
    signal(SIGPIPE, SIG_IGN);
    
    if ((s.epoll_fd = epoll_create1(0)) < 0) { perror("epoll_create1"); free(s.clients); return 1; }
    if ((s.server_fd = create_server(s.cfg.port)) < 0) { close(s.epoll_fd); free(s.clients); return 1; }
    epoll_add(s.epoll_fd, s.server_fd, EPOLLIN);
    
    struct epoll_event *evs = malloc(s.cfg.max_events * sizeof(struct epoll_event));
    if (!evs) { fprintf(stderr, "%s [FATAL] OOM for events\n", s.cfg.log_prefix); cleanup(&s); return 1; }
    
    while (s.running) {
        int nfds = epoll_wait(s.epoll_fd, evs, s.cfg.max_events, 1000);
        if (nfds < 0) { if (errno == EINTR) s.running = 0; else perror("epoll_wait"); break; }
        
        check_heartbeats(&s);
        
        for (int i = 0; i < nfds; i++) {
            int fd = evs[i].data.fd;
            if (fd == s.server_fd) { accept_client(&s); continue; }
            
            uint32_t m = evs[i].events;
            if (m & (EPOLLRDHUP | EPOLLHUP | EPOLLERR))
                remove_client(&s, fd, (m & EPOLLRDHUP) ? DISCONNECTED_GRACEFUL : DISCONNECTED_TIMEOUT);
            else if (m & EPOLLIN) handle_data(&s, fd);
        }
    }
    
    free(evs);
    cleanup(&s);
    printf("%s Goodbye.\n", s.cfg.log_prefix);
    return 0;
}