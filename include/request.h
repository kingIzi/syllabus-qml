#pragma once
#include <QObject>
#include <memory>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QUrl>
#include "operations.h"
#include "response.h"

class Request : public QObject
{
    Q_OBJECT
private:
    std::unique_ptr<QNetworkAccessManager> manager;
    std::unique_ptr<Operations> operations;
    std::unique_ptr<Response> response;
    const QUrl url;
public:
    explicit Request(QObject *parent = nullptr);
    Response* const getResponse() const;
    void signUpUser(QObject * const signUpObject);
    void signInUser(QObject* const signInObject);
    void getCourseList(QObject * const fetchCourses);
    void getCourseSyllabus(QObject *const properties);
signals:

};

