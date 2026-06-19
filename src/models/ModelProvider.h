// ============================================================
// src/models/ModelProvider.h
// ============================================================

#pragma once

#include <QObject>
#include <QVariantList>
#include <QString>

class ModelProvider : public QObject
{
    Q_OBJECT
public:
    explicit ModelProvider(QObject *parent = nullptr);

    Q_INVOKABLE QVariantList getMeshUrls(const QString &modelName);

    Q_INVOKABLE QString getMaterialQmlUrl(const QString &modelName);
};
