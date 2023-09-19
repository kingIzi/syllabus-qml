#pragma once
#include <QObject>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QStringList>
#include <QString>
#include <QVariant>

struct Course {
    Q_GADGET

    Q_PROPERTY(QVariant id MEMBER id)
    Q_PROPERTY(QVariant name MEMBER name)
    Q_PROPERTY(QVariant numSyllabus MEMBER numSyllabus)
public:
    QVariant id;
    QVariant name;
    QVariant numSyllabus;
    Course(const QJsonObject& user) :
        id(user.value("id").toVariant()),name(user.value("name").toVariant()),
        numSyllabus(user.value("numSyllabus").toVariant())

    {}
    Course() = default;
};

struct User{
    Q_GADGET
    Q_PROPERTY(QVariant email MEMBER email)
    Q_PROPERTY(QVariant localId MEMBER localId)
    Q_PROPERTY(QVariant fullName MEMBER fullName)
    Q_PROPERTY(QVariant phoneNo MEMBER phoneNo)
    Q_PROPERTY(QVariant role MEMBER role)
public:
    QVariant id;
    QVariant localId;
    QVariant email;
    QVariant fullName;
    QVariant phoneNo;
    QVariant role;
    User(const QVariant& localId,const QVariant& email,const QVariant& fullName,const QVariant& phoneNo,
         const QVariant& role,const QVariant& id) : localId(localId),email(email),fullName(fullName),
        phoneNo(phoneNo),role(role),id(id)
    {}
    User(const QJsonObject& user) :
        localId(user.value("localId").toVariant()),email(user.value("email").toVariant()),
        fullName(user.value("fullName").toVariant()),phoneNo(user.value("phoneNo").toVariant()),
        role(user.value("role").toVariant())
    {}
    User() = default;
    const bool operator==(const User& user) const{
        return this->id.toString().compare(user.id.toString()) == 0;
    }
    const bool operator!=(const User& user) const{
        return this->id.toString().compare(user.id.toString()) != 0;
    }
    void operator=(const User& user) {
        this->id = user.id;
        this->localId = user.localId;
        this->email = user.email;
        this->fullName = user.fullName;
        this->phoneNo = user.phoneNo;
        this->role = user.role;
    }
};

struct Syllabus {
    Q_GADGET
    Q_PROPERTY(QVariant name MEMBER name)
    Q_PROPERTY(QVariant author MEMBER author)
    Q_PROPERTY(QVariant university MEMBER university)
    Q_PROPERTY(QVariant thumbnail MEMBER thumbnail)
    Q_PROPERTY(QVariant yearGroup MEMBER yearGroup)
    Q_PROPERTY(QVariant languages)
public:
    QVariant name;
    QVariant author;
    QVariant university;
    QVariant thumbnail;
    QVariant yearGroup;
    QVariant languages;
    Syllabus(const QJsonObject syllabus) :
        name(syllabus.value("name").toString()),author(syllabus.value("author").toString()),
        university(syllabus.value("university").toString()),thumbnail(syllabus.value("thumbnail").toString()),
        yearGroup(syllabus.value("yearGroup").toString()),languages(syllabus.value("languages").toVariant().toStringList())
    {}
};




class Response : public QObject
{
    Q_OBJECT
private:
    std::unique_ptr<User> user;
private:
    const QStringList retrieveErrorMessages(const QJsonArray& object) const;
public:
    explicit Response(QObject *parent = nullptr);
    void parseSignUpResponse(const QJsonDocument document);
    void parseSignInResponse(const QJsonDocument document);
    void parseCoursesListResponse(const QJsonDocument document);
    void parseCourseSyllabusResponse(const QJsonDocument document);
    User* const getUser() const;
signals:
    void signUpUserReady(const User);
    void signUpError(const QString);
    void internetFail();

    void signInError(const QString);
    void signInReady(const User);
    void coursesList(const QList<Course>);
    void courseSyllabusList(const QList<Syllabus>);
};

