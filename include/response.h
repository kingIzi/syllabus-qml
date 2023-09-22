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
    Q_PROPERTY(QVariant thumbnail MEMBER thumbnail)
public:
    QVariant id;
    QVariant name;
    QVariant numSyllabus;
    QVariant thumbnail;
    Course(const QJsonObject& course) :
        id(course.value("id").toVariant()),name(course.value("name").toVariant()),
        numSyllabus(course.value("numSyllabus").toVariant()),thumbnail(course.value("thumbnail").toVariant())
    {}
    const bool operator==(const Course& course) const{
        return this->id.toString().compare(course.id.toString()) == 0;
    }
    const bool operator!=(const Course& course) const{
        return this->id.toString().compare(course.id.toString()) != 0;
    }
    Course() = default;
};

struct User{
    Q_GADGET
    Q_PROPERTY(QVariant email MEMBER email)
    Q_PROPERTY(QVariant localId MEMBER localId)
    Q_PROPERTY(QVariant fullName MEMBER fullName)
    Q_PROPERTY(QVariant phoneNo MEMBER phoneNo)
    Q_PROPERTY(QVariant role MEMBER role)
    Q_PROPERTY(QJsonObject user MEMBER user)
public:
    QVariant id;
    QVariant localId;
    QVariant email;
    QVariant fullName;
    QVariant phoneNo;
    QVariant role;
    QJsonObject user;
    User(const QVariant& localId,const QVariant& email,const QVariant& fullName,const QVariant& phoneNo,
         const QVariant& role,const QVariant& id) : localId(localId),email(email),fullName(fullName),
        phoneNo(phoneNo),role(role),id(id)
    {}
    User(const QJsonObject& user) :
        localId(user.value("localId").toVariant()),email(user.value("email").toVariant()),
        fullName(user.value("fullName").toVariant()),phoneNo(user.value("phoneNo").toVariant()),
        role(user.value("role").toVariant()),user(user)
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
    Q_PROPERTY(QVariant id MEMBER id)
    Q_PROPERTY(QVariant name MEMBER name)
    Q_PROPERTY(QVariant author MEMBER author)
    Q_PROPERTY(QVariant university MEMBER university)
    Q_PROPERTY(QVariant thumbnail MEMBER thumbnail)
    Q_PROPERTY(QVariant yearGroup MEMBER yearGroup)
    Q_PROPERTY(QVariant languages MEMBER languages)
    Q_PROPERTY(QVariant lessons MEMBER lessons)
public:
    QVariant id;
    QVariant name;
    QVariant author;
    QVariant university;
    QVariant thumbnail;
    QVariant yearGroup;
    QVariant languages;
    QVariant lessons;
    Syllabus(const QJsonObject syllabus) :
        name(syllabus.value("name").toVariant()),author(syllabus.value("author").toVariant()),
        university(syllabus.value("university").toVariant()),thumbnail(syllabus.value("thumbnail").toVariant()),
        yearGroup(syllabus.value("yearGroup").toVariant()),languages(syllabus.value("languages").toVariant()),
        lessons(syllabus.value("lessons").toVariant())
    {}
    const bool operator==(const Syllabus& syllabus) const{
        return this->name.toString().compare(syllabus.name.toString()) == 0;
    }
    const bool operator!=(const Syllabus& syllabus) const{
        return this->name.toString().compare(syllabus.name.toString()) != 0;
    }
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
    void signInReady();
    void coursesList(const QJsonArray,const QString);
    void courseSyllabusList(const QJsonArray);
};

