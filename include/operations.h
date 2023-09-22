#pragma once
#include <QObject>
#include <QJsonObject>
#include <QJsonArray>
#include <QJsonValue>
#include <QJsonDocument>
#include <QStringList>



class Operations
{
public:
    static constexpr const char* createUser = "mutation($user: SignUpInput!) {\r\n  signUp(user: $user) {\r\n    email,\r\n    phoneNo,\r\n    fullName\r\n    role\r\n, \r\n localId \r\n  }\r\n}";
    static constexpr const char* loginUser = "mutation($user: SignInInput!) {\r\n  signIn(user: $user) {\r\n    email\r\n    phoneNo\r\n    fullName\r\n    role\r\n    localId\r\n  }\r\n}";
    static constexpr const char* coursesList = "query($batchSize: Int!, $cursor: ID!) {\r\n  getCourseList(batchSize: $batchSize, cursor: $cursor) {\r\n    list {\r\n id  \r\n      name\r\n      numSyllabus\r\n      thumbnail\r\n    }\r\n    cursor\r\n  }\r\n}";
    static constexpr const char* courseSyllabus = "query($courseId: String!) {\r\n  getCourseSyllabus(courseId: $courseId) {\r\n thumbnail \r\n    id\r\n    name\r\n    languages\r\n    university\r\n    yearGroup\r\n    lessons {\r\n      description\r\n      metadata {\r\n        name\r\n      }\r\n      url\r\n      name\r\n    }\r\n    author {\r\n      id\r\n      name\r\n    }\r\n  }\r\n}";

    const QStringList coursesKeys = {"batchSize","cursor"};
    const QStringList createUserKeys = {"email","phoneNo","password","role","fullName"};
    const QStringList signInKeys = {"email","password"};
    const QStringList courseSyllabusKeys = {"courseId"};
public:
    Operations();

    const QJsonObject buildVariables(const QStringList& keys, QObject* const properties) const;
    const QStringList& getCreateUserKeys() const;
    const QStringList& getSignInKeys() const;
    const QJsonDocument createDocument(const char *query, const QJsonObject &variables) const;
};



