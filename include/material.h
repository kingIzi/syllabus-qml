#pragma once
#include <QObject>
#include <QJsonObject>
#include <QJsonArray>

class Material : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString id READ id WRITE setId NOTIFY idChanged)
    Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY titleChanged)
    Q_PROPERTY(QString thumbnail READ thumbnail WRITE setThumbnail NOTIFY thumbnailChanged)
private:
    QString id_m;
    QString title_m;
    QString thumbnail_m;
public:
    explicit Material(QObject * parent = nullptr);
    explicit Material(const QJsonObject& material,QObject * parent = nullptr);
    const QString& id() const;
    const QString& title() const;
    const QString& thumbnail() const;
public:
    const bool operator==(const Material& material) const{
        const auto matchId = this->id_m.compare(material.id()) == 0;
        const auto matchTitle = this->title_m.compare(material.title()) == 0;
        const auto matchThumbnail = this->thumbnail_m.compare(material.thumbnail()) == 0;
        return matchId && matchTitle && matchThumbnail;
    }
public slots:
    void setId(const QString& id);
    void setTitle(const QString& title);
    void setThumbnail(const QString& thumbnail);
signals:
    void idChanged();
    void titleChanged();
    void thumbnailChanged();
};

