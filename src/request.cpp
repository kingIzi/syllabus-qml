#include "request.h"
#include <QHttpMultiPart>
#include <QHttpPart>


void Request::connectUploadProgressSignal(QNetworkReply * const reply)
{
    QObject::connect(reply,&QNetworkReply::uploadProgress,this,[this](qint64 bytesSent,qint64 bytesTotal){
        const auto percent = (static_cast<double>(bytesSent) / static_cast<double>(bytesTotal)) * 100.0;
        qDebug() << percent;
    });
}

void Request::connectSignInReply(QNetworkReply * const reply)
{
    this->connectUploadProgressSignal(reply);
    QObject::connect(reply,&QNetworkReply::finished,this,[reply,this](){
        const auto res = QJsonDocument::fromJson(reply->readAll());
        this->response->parseSignInResponse(res);
        reply->deleteLater();
    });
}

Request::Request(QObject *parent)
    : QObject{parent},
      manager(std::make_unique<QNetworkAccessManager>(this)),
      operations(std::make_unique<Operations>()),
      response(std::make_unique<Response>()),
      url("http://localhost:5000/syllabustz-bd7fd/us-central1/helloWorld")
{

}

Response * const Request::getResponse() const
{
    return this->response.get();
}

void Request::signUpUser(QObject * const signUpObject)
{
    try {
        const auto variables = this->operations->buildVariables(this->operations->getCreateUserKeys(),signUpObject);
        QJsonObject user;
        user.insert("user",variables);
        const auto document = this->operations->createDocument(Operations::createUser,user);
        QNetworkRequest request(this->url);
        request.setHeader(QNetworkRequest::ContentTypeHeader,"application/json");
        const auto reply = this->manager->post(request,document.toJson());
        QObject::connect(reply,&QNetworkReply::finished,this,[reply,this](){
            const auto res = QJsonDocument::fromJson(reply->readAll());
            this->response->parseSignUpResponse(res);
            reply->deleteLater();
        });
    } catch (const std::exception& e) {
        qDebug() << e.what();
    }
}

void Request::signInUser(QObject * const signInObject)
{
    try {
        const auto variables = this->operations->buildVariables(this->operations->getSignInKeys(),signInObject);
        QJsonObject user({{QString("user"),variables}});
        const auto document = this->operations->createDocument(Operations::loginUser,user);
        QNetworkRequest request(this->url);
        request.setHeader(QNetworkRequest::ContentTypeHeader,"application/json");
        const auto reply = this->manager->post(request,document.toJson());
        this->connectSignInReply(reply);
    } catch (const std::exception& e) {
        qDebug() << e.what();
    }
}

void Request::getCourseList(QObject * const fetchCourses)
{
    try {
        const auto variables = this->operations->buildVariables(this->operations->coursesKeys,fetchCourses);
        const auto document = this->operations->createDocument(Operations::coursesList,variables);
        QNetworkRequest request(this->url);
        request.setHeader(QNetworkRequest::ContentTypeHeader,"application/json");
        const auto reply = this->manager->post(request,document.toJson());
        QObject::connect(reply,&QNetworkReply::finished,this,[this,reply](){
            const auto res = QJsonDocument::fromJson(reply->readAll());
            this->response->parseCoursesListResponse(res);
            reply->deleteLater();
        });
    } catch (const std::exception& e) {
        qDebug() << e.what();
    }
}

void Request::getCourseSyllabus(QObject * const properties)
{
    try {
        const auto variables = this->operations->buildVariables(this->operations->courseSyllabusKeys,properties);
        const auto document = this->operations->createDocument(Operations::courseSyllabus,variables);
        QNetworkRequest request(this->url);
        request.setHeader(QNetworkRequest::ContentTypeHeader,"application/json");
        const auto reply = this->manager->post(request,document.toJson());
        QObject::connect(reply,&QNetworkReply::finished,this,[this,reply](){
            const auto res = QJsonDocument::fromJson(reply->readAll());
            this->response->parseCourseSyllabusResponse(res);
            reply->deleteLater();
        });
    } catch (const std::exception& e) {
        qDebug() << e.what();
    }
}
