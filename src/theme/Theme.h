// src/theme/Theme.h
#pragma once

#include <QObject>
#include <QColor>
#include <QString>
#include <QQmlEngine>

class Theme : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON

    // Цвета
    Q_PROPERTY(QColor bgColor READ bgColor NOTIFY themeChanged)
    Q_PROPERTY(QColor cardColor READ cardColor NOTIFY themeChanged)
    Q_PROPERTY(QColor accentColor READ accentColor NOTIFY themeChanged)
    Q_PROPERTY(QColor accentDim READ accentDim NOTIFY themeChanged)
    Q_PROPERTY(QColor warningColor READ warningColor NOTIFY themeChanged)
    Q_PROPERTY(QColor textColor READ textColor NOTIFY themeChanged)
    Q_PROPERTY(QColor textHighlight READ textHighlight NOTIFY themeChanged)

    // Типографика
    Q_PROPERTY(QString fontFamily READ fontFamily CONSTANT)
    Q_PROPERTY(int textBaseFontSize READ textBaseFontSize CONSTANT)
    Q_PROPERTY(int titleFontSize READ titleFontSize CONSTANT)
    Q_PROPERTY(qreal letterSpacing READ letterSpacing CONSTANT)

    // Карточка
    Q_PROPERTY(int cartRadius READ cartRadius CONSTANT)
    Q_PROPERTY(int cartBorderWidth READ cartBorderWidth CONSTANT)
    Q_PROPERTY(QColor cartBorderColor READ cartBorderColor NOTIFY themeChanged)

    // Кнопки
    Q_PROPERTY(int buttonWidth READ buttonWidth CONSTANT)
    Q_PROPERTY(int buttonHeight READ buttonHeight CONSTANT)
    Q_PROPERTY(int buttonFontSize READ buttonFontSize CONSTANT)
    Q_PROPERTY(int buttonRadius READ buttonRadius CONSTANT)
    Q_PROPERTY(int buttonBorderWidth READ buttonBorderWidth CONSTANT)
    Q_PROPERTY(int cornerMarkSize READ cornerMarkSize CONSTANT)
    Q_PROPERTY(int cornerMarkThick READ cornerMarkThick CONSTANT)

public:
    explicit Theme(QObject *parent = nullptr);

    static Theme *create(QQmlEngine *qmlEngine, QJSEngine *jsEngine) {
        Q_UNUSED(qmlEngine)
        Q_UNUSED(jsEngine)
        static Theme instance;
        return &instance;
    }

    // Геттеры
    QColor bgColor() const { return m_bgColor; }
    QColor cardColor() const { return m_cardColor; }
    QColor accentColor() const { return m_accentColor; }
    QColor accentDim() const { return m_accentDim; }
    QColor warningColor() const { return m_warningColor; }
    QColor textColor() const { return m_textColor; }
    QColor textHighlight() const { return m_textHighlight; }

    QString fontFamily() const { return "Tahoma"; }
    int textBaseFontSize() const { return 26; }
    int titleFontSize() const { return 32; }
    qreal letterSpacing() const { return 1.5; }

    int cartRadius() const { return 0; }
    int cartBorderWidth() const { return 2; }
    QColor cartBorderColor() const { return m_accentDim; }

    int buttonWidth() const { return 170; }
    int buttonHeight() const { return 48; }
    int buttonFontSize() const { return 12; }
    int buttonRadius() const { return 0; }
    int buttonBorderWidth() const { return 2; }
    int cornerMarkSize() const { return 12; }
    int cornerMarkThick() const { return 2; }

    Q_INVOKABLE void setDarkMode(bool dark);

signals:
    void themeChanged();

private:
    QColor m_bgColor;
    QColor m_cardColor;
    QColor m_accentColor;
    QColor m_accentDim;
    QColor m_warningColor;
    QColor m_textColor;
    QColor m_textHighlight;
};

//#pragma once

//#include <QObject>
//#include <QColor>
//#include <QString>

//class Theme : public QObject
//{
//    Q_OBJECT

//    // Цвета
//    Q_PROPERTY(QColor bgColor READ bgColor NOTIFY themeChanged)
//    Q_PROPERTY(QColor cardColor READ cardColor NOTIFY themeChanged)
//    Q_PROPERTY(QColor accentColor READ accentColor NOTIFY themeChanged)
//    Q_PROPERTY(QColor accentDim READ accentDim NOTIFY themeChanged)
//    Q_PROPERTY(QColor warningColor READ warningColor NOTIFY themeChanged)
//    Q_PROPERTY(QColor textColor READ textColor NOTIFY themeChanged)
//    Q_PROPERTY(QColor textHighlight READ textHighlight NOTIFY themeChanged)

//    // Типографика
//    Q_PROPERTY(QString fontFamily READ fontFamily CONSTANT)
//    Q_PROPERTY(int textBaseFontSize READ textBaseFontSize CONSTANT)
//    Q_PROPERTY(int titleFontSize READ titleFontSize CONSTANT)
//    Q_PROPERTY(qreal letterSpacing READ letterSpacing CONSTANT)

//    // Карточка
//    Q_PROPERTY(int cartRadius READ cartRadius CONSTANT)
//    Q_PROPERTY(int cartBorderWidth READ cartBorderWidth CONSTANT)
//    Q_PROPERTY(QColor cartBorderColor READ cartBorderColor NOTIFY themeChanged)

//    // Кнопки
//    Q_PROPERTY(int buttonWidth READ buttonWidth CONSTANT)
//    Q_PROPERTY(int buttonHeight READ buttonHeight CONSTANT)
//    Q_PROPERTY(int buttonFontSize READ buttonFontSize CONSTANT)
//    Q_PROPERTY(int buttonRadius READ buttonRadius CONSTANT)
//    Q_PROPERTY(int buttonBorderWidth READ buttonBorderWidth CONSTANT)
//    Q_PROPERTY(int cornerMarkSize READ cornerMarkSize CONSTANT)
//    Q_PROPERTY(int cornerMarkThick READ cornerMarkThick CONSTANT)

//public:
//    explicit Theme(QObject *parent = nullptr);

//    // Геттеры
//    QColor bgColor() const { return m_bgColor; }
//    QColor cardColor() const { return m_cardColor; }
//    QColor accentColor() const { return m_accentColor; }
//    QColor accentDim() const { return m_accentDim; }
//    QColor warningColor() const { return m_warningColor; }
//    QColor textColor() const { return m_textColor; }
//    QColor textHighlight() const { return m_textHighlight; }

//    QString fontFamily() const { return "Tahoma"; }
//    int textBaseFontSize() const { return 26; }
//    int titleFontSize() const { return 32; }
//    qreal letterSpacing() const { return 1.5; }

//    int cartRadius() const { return 0; }
//    int cartBorderWidth() const { return 2; }
//    QColor cartBorderColor() const { return m_accentDim; }

//    int buttonWidth() const { return 170; }
//    int buttonHeight() const { return 48; }
//    int buttonFontSize() const { return 12; }
//    int buttonRadius() const { return 0; }
//    int buttonBorderWidth() const { return 2; }
//    int cornerMarkSize() const { return 12; }
//    int cornerMarkThick() const { return 2; }

//    // Методы для смены темы
//    Q_INVOKABLE void setDarkMode(bool dark);

//signals:
//    void themeChanged();

//private:
//    QColor m_bgColor;
//    QColor m_cardColor;
//    QColor m_accentColor;
//    QColor m_accentDim;
//    QColor m_warningColor;
//    QColor m_textColor;
//    QColor m_textHighlight;
//};
