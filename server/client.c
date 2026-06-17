/*
 * Heartbeat Client for Prometheus Socket Engine
 * =============================================
 * Auto-reconnecting TCP client with PING/PONG heartbeat.
 * Build: gcc -O2 -Wall -std=c11 -o hb_client hb_client.c
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <stdbool.h>
#include <signal.h>
#include <errno.h>
#include <sys/socket.h>
#include <sys/select.h>
#include <netinet/in.h>
#include <arpa/inet.h>

#define SERVER_IP       "192.9.192.5"
#define SERVER_PORT     8089
#define HEARTBEAT_SEC   2
#define RECONNECT_DELAY 1

static volatile sig_atomic_t running = 1;

static void sig_handler(int sig) { (void)sig; running = 0; }

static int try_connect(void) {
    struct sockaddr_in addr = {
        .sin_family = AF_INET,
        .sin_port = htons(SERVER_PORT),
        .sin_addr.s_addr = inet_addr(SERVER_IP)
    };
    
    while (running) {
        int sock = socket(AF_INET, SOCK_STREAM, 0);
        if (sock < 0) { sleep(RECONNECT_DELAY); continue; }
        
        if (connect(sock, (struct sockaddr*)&addr, sizeof(addr)) == 0) {
            printf("[CLIENT] Connected to %s:%d\n", SERVER_IP, SERVER_PORT);
            return sock;
        }
        
        printf("[CLIENT] Connect failed: %s. Retrying...\n", strerror(errno));
        close(sock);
        sleep(RECONNECT_DELAY);
    }
    return -1;
}

static bool send_ping(int sock) {
    return send(sock, "PING", 4, MSG_NOSIGNAL) == 4;
}

static bool wait_pong(int sock) {
    fd_set fds;
    FD_ZERO(&fds);
    FD_SET(sock, &fds);
    
    struct timeval tv = { .tv_sec = 1, .tv_usec = 0 };
    if (select(sock + 1, &fds, NULL, NULL, &tv) <= 0) {
        printf("[CLIENT] No PONG received (timeout)\n");
        return true;  /* Не фатально, продолжаем */
    }
    
    char buf[64];
    ssize_t n = recv(sock, buf, sizeof(buf) - 1, 0);
    
    if (n > 0) {
        buf[n] = '\0';
        printf("[CLIENT] Received: %s\n", buf);
        return true;
    }
    
    printf("[CLIENT] Connection lost (%s)\n", n == 0 ? "server closed" : strerror(errno));
    return false;
}

int main(void) {
    signal(SIGINT, sig_handler);
    signal(SIGTERM, sig_handler);
    signal(SIGPIPE, SIG_IGN);
    
    printf("[CLIENT] Heartbeat client (%s:%d, every %ds)\n", 
           SERVER_IP, SERVER_PORT, HEARTBEAT_SEC);
    printf("[CLIENT] Ctrl+C to stop\n\n");
    
    int sock = try_connect();
    if (sock < 0) goto cleanup;
    
    while (running) {
        /* Send heartbeat */
        if (!send_ping(sock)) {
            printf("[CLIENT] Send failed: %s\n", strerror(errno));
            close(sock);
            sock = try_connect();
            if (sock < 0) goto cleanup;
            printf("[CLIENT] Reconnected! Resuming...\n");
            continue;
        }
        printf("[CLIENT] PING sent\n");
        
        /* Wait for PONG */
        if (!wait_pong(sock)) {
            close(sock);
            sock = try_connect();
            if (sock < 0) goto cleanup;
            printf("[CLIENT] Reconnected! Resuming...\n");
            continue;
        }
        
        sleep(HEARTBEAT_SEC);
    }
    
cleanup:
    printf("[CLIENT] Shutting down gracefully...\n");
    if (sock >= 0) { shutdown(sock, SHUT_RDWR); close(sock); }
    return EXIT_SUCCESS;
}