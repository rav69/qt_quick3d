#pragma once
#include <QAbstractItemModel>
#include <QStringList>

class VirtualFileTreeModel : public QAbstractItemModel
{
    Q_OBJECT
    Q_PROPERTY(QStringList filePaths READ filePaths WRITE setFilePaths NOTIFY filePathsChanged)

public:
    explicit VirtualFileTreeModel(QObject *parent = nullptr);

    QStringList filePaths() const;
    void setFilePaths(const QStringList &paths);

    Q_INVOKABLE void loadFromPaths(const QStringList &paths);

    // QAbstractItemModel interface
    QModelIndex index(int row, int column, const QModelIndex &parent) const override;
    QModelIndex parent(const QModelIndex &child) const override;
    int rowCount(const QModelIndex &parent) const override;
    int columnCount(const QModelIndex &parent) const override;
    QVariant data(const QModelIndex &index, int role) const override;

signals:
    void filePathsChanged();

private:
    struct Node {
        QString name;
        bool isFile;
        QVector<Node> children;
        Node *parent = nullptr;

        bool operator==(const Node &other) const {
            return this == &other; // сравниваем по адресу
        }
    };

    Node m_root;
    QHash<QString, Node*> m_nodeMap; // для быстрого поиска
    void buildTree(const QStringList &paths);
    QModelIndex indexForNode(const Node *node, int column) const;
    Node *nodeFromIndex(const QModelIndex &index) const;

    QStringList m_filePaths;
};
