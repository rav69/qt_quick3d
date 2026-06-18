#include "ModelProvider.h"
#include <QCoreApplication>
#include <QDir>
#include <QUrl>
#include <QFileInfo>
#include <QDebug>

ModelProvider::ModelProvider(QObject *parent) : QObject(parent) {}

QVariantList ModelProvider::getMeshUrls(const QString &modelName)
{
    // Формируем путь: /путь_к_exe/models/имя_модели
    QString dirPath = QCoreApplication::applicationDirPath() + "/models/" + modelName + "/meshes";
    QDir dir(dirPath);

    if (!dir.exists()) {
        qWarning() << "Папка модели не найдена:" << dirPath;
        return QVariantList();
    }

    // Ищем все .mesh файлы в этой папке
    QFileInfoList files = dir.entryInfoList(QStringList() << "*.mesh", QDir::Files);
    QVariantList urls;

    for (const QFileInfo &file : files) {
        // QUrl::fromLocalFile идеально работает в Астра Линукс
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
//QString ModelProvider::getMaterialQmlUrl(const QString &modelName)
//{
//    // !!! ЗАМЕНИ "Material_0.qml" на ТОЧНОЕ имя файла, который создал Balsam !!!
//    QString materialFileName = "Material_0.qml";

////    QString fullPath = QCoreApplication::applicationDirPath() + "/models/" + modelName + "/maps/" + materialFileName;
//    QString fullPath = QCoreApplication::applicationDirPath() + "/models/" + modelName + "/" + materialFileName;
//    QFileInfo fi(fullPath);

//    if (fi.exists()) {
//        // Возвращаем абсолютный URL: "file:///home/.../maps/Material_0.qml"
//        // Возвращаем абсолютный URL: "file:///home/.../Material_0.qml"
//        return QUrl::fromLocalFile(fi.absoluteFilePath()).toString();
//    }

//    qWarning() << "Файл материала не найден:" << fullPath;
//    return "";
//}
