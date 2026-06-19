// ============================================================
// src/models/ModelProvider.cpp
// ============================================================

#include "ModelProvider.h"
#include <QCoreApplication>
#include <QDir>
#include <QUrl>
#include <QFileInfo>
#include <QDebug>

ModelProvider::ModelProvider(QObject *parent) : QObject(parent) {}

QVariantList ModelProvider::getMeshUrls(const QString &modelName)
{
    // Build path: /path_to_exe/models/model_name/meshes
    QString dirPath = QCoreApplication::applicationDirPath() + "/models/" + modelName + "/meshes";
    QDir dir(dirPath);

    if (!dir.exists()) {
        qWarning() << "Папка модели не найдена:" << dirPath;
        return QVariantList();
    }

    // Find all .mesh files in this folder
    QFileInfoList files = dir.entryInfoList(QStringList() << "*.mesh", QDir::Files);
    QVariantList urls;

    for (const QFileInfo &file : files) {
        // QUrl::fromLocalFile works perfectly in Astra Linux
        urls.append(QUrl::fromLocalFile(file.absoluteFilePath()));
    }

    qDebug() << "Найдено" << urls.size() << "файлов .mesh для модели:" << modelName;
    return urls;
}

QString ModelProvider::getMaterialQmlUrl(const QString &modelName)
{
    QString modelDirPath = QCoreApplication::applicationDirPath() + "/models/" + modelName;
    QDir modelDir(modelDirPath);

    if (!modelDir.exists()) {
        qWarning() << "Папка модели не найдена:" << modelDirPath;
        return "";
    }

    QFileInfoList qmlFiles = modelDir.entryInfoList(QStringList() << "*.qml", QDir::Files);

    if (qmlFiles.isEmpty()) {
        qWarning() << "В папке модели не найдено ни одного .qml файла:" << modelDirPath;
        return "";
    }

    if (qmlFiles.size() > 1) {
        qInfo() << "Найдено" << qmlFiles.size() << ".qml файлов. Используем первый:" << qmlFiles.first().fileName();
    }

    return QUrl::fromLocalFile(qmlFiles.first().absoluteFilePath()).toString();
}
