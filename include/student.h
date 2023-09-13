#pragma once
#include <QObject>
#include <QJsonObject>

class Student : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString id READ id WRITE setId NOTIFY idChanged)
    Q_PROPERTY(QString email READ email WRITE setEmail NOTIFY emailChanged)
    Q_PROPERTY(QStringList favorites READ favorites WRITE setFavorites NOTIFY favoritesChanged)
    Q_PROPERTY(QString fullName READ fullName WRITE setFullName NOTIFY fullNameChanged)
    Q_PROPERTY(QString phoneNo READ phoneNo WRITE setPhoneNo NOTIFY phoneNoChanged)
    Q_PROPERTY(QString localId READ localId WRITE setLocalId NOTIFY localIdChanged)
private:
    QJsonObject student;
    QString m_id;
    QString m_email;
    QStringList m_favorites;
    QString m_fullName;
    QString m_phoneNo;
    QString m_localId;
public:
    explicit Student(QObject *parent = nullptr);
    explicit Student(const QJsonObject& student,QObject * parent = nullptr);
public slots:
    const QString& id() const;
    const QString& email() const;
    const QStringList& favorites() const;
    const QString& fullName() const;
    const QString& phoneNo() const;
    const QString& localId() const;
    const QJsonObject getObject() const;
    void setId(const QString& id);
    void setEmail(const QString& email);
    void setFavorites(const QStringList& favorites);
    void setFullName(const QString& fullName);
    void setPhoneNo(const QString& phoneNo);
    void setLocalId(const QString& localId);
signals:
    void idChanged();
    void emailChanged();
    void favoritesChanged();
    void fullNameChanged();
    void phoneNoChanged();
    void localIdChanged();
};

