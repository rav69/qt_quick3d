// ============================================================
// src/theme/Theme.cpp
// ============================================================

#include "Theme.h"

Theme::Theme(QObject *parent) : QObject(parent)
{
    // Устанавливаем тему по умолчанию (Desert Ops)
    setDarkMode(true);
}

void Theme::setDarkMode(bool dark)
{
    if (dark) {
        // Тёмная тема (Desert Ops)
        m_bgColor = QColor("#1C1814");
        m_cardColor = QColor("#A000BFFF");
        m_accentColor = QColor("#D4A574");
        m_accentDim = QColor("#8B7355");
        m_warningColor = QColor("#E74C3C");
        m_textColor = QColor("#E8DCC4");
        m_textHighlight = QColor("#F4C983");
    } else {
        // Светлая тема (можно добавить позже)
        m_bgColor = QColor("#F5F0E8");
        m_cardColor = QColor("#E0D5C8");
        m_accentColor = QColor("#C49A6C");
        m_accentDim = QColor("#A08060");
        m_warningColor = QColor("#CC3333");
        m_textColor = QColor("#2C2418");
        m_textHighlight = QColor("#C49A6C");
    }
    emit themeChanged();
}
