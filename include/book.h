#pragma once
#include <QObject>
#include <QDate>
#include <QDateTime>
#include <QStringList>
#include <QJsonObject>

class Book : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString summary READ summary WRITE setSummary NOTIFY summaryChanged)
    Q_PROPERTY(QString id READ id WRITE setId NOTIFY idChanged)
    Q_PROPERTY(QString thumbnail READ thumbnail WRITE setThumbnail NOTIFY thumbnailChanged)
    Q_PROPERTY(QString dataUrl READ dataUrl WRITE setDataUrl NOTIFY dataUrlChanged)
    Q_PROPERTY(qint8 level READ level WRITE setLevel NOTIFY levelChanged)
    Q_PROPERTY(QDateTime published READ published WRITE setPublished NOTIFY publishedChanged)
    Q_PROPERTY(QString authorId READ authorId WRITE setAuthorId NOTIFY authorIdChanged)
    Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY titleChanged)
    Q_PROPERTY(QStringList languages READ languages WRITE setLanguages NOTIFY languagesChanged)
    Q_PROPERTY(QString author READ author WRITE setAuthor NOTIFY authorChanged)
private:
    QString summary_m;
    QString id_m;
    QString thumbnail_m;
    QString dataUrl_m;
    qint8 level_m;
    QDateTime published_m;
    QString authorId_m;
    QString title_m;
    QStringList languages_m;
    QString author_m;
public:
    const bool operator==(const Book& book) const {
        return this->id_m.compare(book.id()) == 0;
    }
public:
    explicit Book(QObject *parent = nullptr);
    explicit Book(const QJsonObject& book,QObject* parent = nullptr);
    const QString& summary() const;
    const QString& id() const;
    const QString& thumbnail() const;
    const QString& dataUrl() const;
    const qint8& level() const;
    const QDateTime& published() const;
    const QString& authorId() const;
    const QString& title() const;
    const QStringList& languages() const;
    const QString& author() const;
public slots:
    void setSummary(const QString&  summary);
    void setId(const QString& id);
    void setThumbnail(const QString& thumbnail);
    void setDataUrl(const QString& dataUrl);
    void setLevel(const qint8& level);
    void setPublished(const QDateTime& published);
    void setAuthorId(const QString& authorId);
    void setTitle(const QString& title);
    void setLanguages(const QStringList& languages);
    void setAuthor(const QString& author);
signals:
    void summaryChanged();
    void idChanged();
    void thumbnailChanged();
    void dataUrlChanged();
    void levelChanged();
    void publishedChanged();
    void authorIdChanged();
    void titleChanged();
    void languagesChanged();
    void authorChanged();
};

