#include "VirtualFileTreeModel.h"
#include <QDebug>

VirtualFileTreeModel::VirtualFileTreeModel(QObject *parent) : QAbstractItemModel(parent) {}

QStringList VirtualFileTreeModel::filePaths() const { return m_filePaths; }

void VirtualFileTreeModel::setFilePaths(const QStringList &paths)
{
    if (m_filePaths == paths) return;
    m_filePaths = paths;
    buildTree(paths);
    emit filePathsChanged();
}

void VirtualFileTreeModel::loadFromPaths(const QStringList &paths)
{
    setFilePaths(paths);
}

void VirtualFileTreeModel::buildTree(const QStringList &paths)
{
    beginResetModel();
    m_root = Node{"/", false, {}};
    m_nodeMap.clear();

    for (const QString &fullPath : paths) {
        QStringList parts = fullPath.split('/', Qt::SkipEmptyParts);
        Node *current = &m_root;

        for (int i = 0; i < parts.size(); ++i) {
            const QString &part = parts[i];
            bool isFile = (i == parts.size() - 1);

            // ищем дочерний узел с таким именем
            bool found = false;
            for (int j = 0; j < current->children.size(); ++j) {
                if (current->children[j].name == part) {
                    current = &current->children[j];
                    found = true;
                    break;
                }
            }
            if (!found) {
                Node newNode{part, isFile, {}};
                current->children.append(newNode);
                Node *newNodePtr = &current->children.last();
                newNodePtr->parent = current;
                current = newNodePtr;
            }
        }
    }
    endResetModel();
}

QModelIndex VirtualFileTreeModel::index(int row, int column, const QModelIndex &parent) const
{
    if (!hasIndex(row, column, parent)) return QModelIndex();
    Node *parentNode = nodeFromIndex(parent);
    if (!parentNode) parentNode = const_cast<Node*>(&m_root);
    if (row < 0 || row >= parentNode->children.size()) return QModelIndex();
    return createIndex(row, column, &parentNode->children[row]);
}

QModelIndex VirtualFileTreeModel::parent(const QModelIndex &child) const
{
    if (!child.isValid()) return QModelIndex();
    Node *childNode = nodeFromIndex(child);
    if (!childNode || !childNode->parent) return QModelIndex();
    Node *parentNode = childNode->parent;
    return indexForNode(parentNode, child.column());
}

int VirtualFileTreeModel::rowCount(const QModelIndex &parent) const
{
    Node *parentNode = nodeFromIndex(parent);
    if (!parentNode) parentNode = const_cast<Node*>(&m_root);
    return parentNode->children.size();
}

int VirtualFileTreeModel::columnCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return 1; // только имя
}

QVariant VirtualFileTreeModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid()) return QVariant();
    Node *node = nodeFromIndex(index);
    if (!node) return QVariant();
    if (role == Qt::DisplayRole) return node->name;
    if (role == Qt::DecorationRole) {
        return node->isFile ? "file" : "folder";
    }
    return QVariant();
}

QModelIndex VirtualFileTreeModel::indexForNode(const Node *node, int column) const
{
    if (!node || node == &m_root) return QModelIndex();
    Node *parentNode = node->parent;
    if (!parentNode) return QModelIndex();
    int row = parentNode->children.indexOf(const_cast<Node&>(*node));
    if (row == -1) return QModelIndex();
    return createIndex(row, column, const_cast<Node*>(node));
}

VirtualFileTreeModel::Node *VirtualFileTreeModel::nodeFromIndex(const QModelIndex &index) const
{
    if (!index.isValid()) return nullptr;
    return static_cast<Node*>(index.internalPointer());
}
