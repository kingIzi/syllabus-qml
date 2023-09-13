#include "student.h"

Student::Student(QObject *parent)
    : QObject{parent}
{

}

Student::Student(const QJsonObject &student, QObject *parent) :
    QObject{parent},m_id(student.value("id").toString()),student(student),
    m_email(student.value("email").toString()),m_fullName(student.value("fullName").toString()),
    m_favorites(student.value("favorites").toVariant().toStringList()),
    m_phoneNo(student.value("phoneNo").toString()),m_localId(student.value("localId").toString())
{

}

const QString &Student::id() const
{
    return this->m_id;
}

const QString &Student::email() const
{
    return this->m_email;
}

const QStringList &Student::favorites() const
{
    return this->m_favorites;
}

const QString &Student::fullName() const
{
    return this->m_fullName;
}

const QString &Student::phoneNo() const
{
    return this->m_phoneNo;
}

const QString &Student::localId() const
{
    return this->m_localId;
}

const QJsonObject Student::getObject() const
{
    return this->student;
}

void Student::setId(const QString &id)
{
    if (this->m_id != id){
        this->m_id = id;
        emit Student::idChanged();
    }
}

void Student::setEmail(const QString &email)
{
    if (this->m_email != email){
        this->m_email = email;
        emit Student::emailChanged();
    }
}

void Student::setFavorites(const QStringList &favorites)
{
    if (this->m_favorites != favorites){
        this->m_favorites = favorites;
        emit Student::favoritesChanged();
    }
}

void Student::setFullName(const QString &fullName)
{
    if (this->m_fullName != fullName){
        this->m_fullName = fullName;
        emit Student::fullNameChanged();
    }
}

void Student::setPhoneNo(const QString &phoneNo)
{
    if (this->m_phoneNo != phoneNo){
        this->m_phoneNo = phoneNo;
        emit Student::phoneNoChanged();
    }
}

void Student::setLocalId(const QString &localId)
{
    if (this->m_localId != localId){
        this->m_localId = localId;
        emit Student::localIdChanged();
    }
}
