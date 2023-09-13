#include "admin.h"
#include <QMetaObject>
#include <QMetaProperty>
#include <map>
#include <QUrlQuery>
#include <QNetworkReply>
#include <QNetworkRequest>

std::map<QString, QVariant> Admin::QObjectPropertiesToMap(QObject *const object,const QStringList& propertyNames)
{
    std::map<QString, QVariant> map;
    const QMetaObject* metaObject = object->metaObject();
    for (int i = 0; i < metaObject->propertyCount(); ++i){
        const QMetaProperty metaProperty = metaObject->property(i);
        const QString propertyName = metaProperty.name();
        if (propertyNames.contains(propertyName)){
            const QVariant propertyValue = object->property(propertyName.toUtf8());
            map[propertyName] = propertyValue;
        }
    }
    return map;
}

const QStringList Admin::signUpProperties() const
{
    return {"fullName","phoneNo","password","email","role"};
}

const QStringList Admin::signInProperties() const
{
    return {"email","password"};
}

const QStringList Admin::updateStudentProperties() const
{
    return {"idToken","studentId","password","idToken"};
}

QUrl Admin::buildUrl(const char *path, const QList<QPair<QString, QString> > queries) const
{
    QUrl url(Endpoints::baseUrl);
    url.setPath(path);
    if (!queries.isEmpty()){
        QUrlQuery query;
        query.setQueryItems(queries);
        url.setQuery(query);
    }
    return url;
}

void Admin::signUpResponse(const QJsonDocument response)
{
    const auto code = response.object().value("status").toObject().value("code").toVariant().toString().toInt();
    if (code == 200){
        const auto data = response.object().value("response").toObject();
        this->idToken = data.value("idToken").toVariant().toString().toStdString();
        this->email = data.value("email").toVariant().toString().toStdString();
        this->refreshToken = data.value("refreshToken").toVariant().toString().toStdString();
        this->setIsLoggedIn(true);
    }
    else if (code == 400){
        const auto message = response.object().value("error").toObject().value("message").toVariant().toString();
        emit Admin::signUpFailed(message);
    }
}

void Admin::signInResponse(const QJsonDocument response)
{
    const auto code = response.object().value("status").toObject().value("code").toVariant().toString().toInt();
    if (code == 200){
        const auto data = response.object().value("response").toObject();
        this->idToken = data.value("idToken").toVariant().toString().toStdString();
        this->email = data.value("email").toVariant().toString().toStdString();
        this->refreshToken = data.value("refreshToken").toVariant().toString().toStdString();
        this->setIsLoggedIn(true);
    }
    else if (code == 400){
        auto message = response.object().value("error").toObject().value("message").toVariant().toString();
        emit Admin::signInFailed(message.replace('_',' ').toLower());
    }
}

void Admin::materialListResponse(const QJsonDocument response)
{
    const auto code = response.object().value("status").toObject().value("code").toVariant().toString().toInt();
    if (code == 200){
        const auto data = response.object().value("response").toArray();
        QList<Material*> materials; materials.reserve(data.size());
        for (const auto& material : data){
            materials.emplaceBack(new Material(material.toObject()));
        }
        emit Admin::materialList(materials);
    }
    else if (code == 400){
        //to do error handling
    }
}

void Admin::topicsForResponse(const QJsonDocument response)
{
    const auto code = response.object().value("status").toObject().value("code").toVariant().toString().toInt();
    if (code == 200){
        const auto data = response.object().value("response").toArray();
        QList<Book*> books; books.reserve(data.size());
        for (const auto& book : data){
            books.emplaceBack(new Book(book.toObject()));
        }
        emit Admin::topicsForList(books);
    }
    else if (code == 400){
        //to do error handling
    }
}

void Admin::findUserResponse(const QJsonDocument response)
{
    const auto code = response.object().value("status").toObject().value("code").toVariant().toString().toInt();
    if (code == 200){
        const auto data = response.object().value("response").toObject();
        this->student_ptr = std::make_unique<Student>(data,this);
    }
    else if (code == 400){
        //to do error handling
    }
}

void Admin::favoriteResponse(const QJsonDocument response)
{
    const auto code = response.object().value("status").toObject().value("code").toVariant().toString().toInt();
    if (code == 200){
        const auto data = response.object().value("response").toObject();
        const auto favorites = data.value("favorites").toVariant().toStringList();
        this->setFavorites(favorites);
    }
    else if (code == 400){
        //to do error handling
    }
}

void Admin::updateUserResponse(const QJsonDocument response)
{
    const auto code = response.object().value("status").toObject().value("code").toVariant().toString().toInt();
    if (code == 200){
        const auto data = response.object().value("response").toObject();
        this->idToken = data.value("idToken").toString().toStdString();
        this->refreshToken = data.value("refreshToken").toString().toStdString();
        this->email = data.value("email").toString().toStdString();
    }
    else if (code == 400){
        //to do error handling
    }
}

void Admin::searchByTextResponse(const QJsonDocument response)
{
    const auto code = response.object().value("status").toObject().value("code").toVariant().toString().toInt();
    if (code == 200){
        const auto data = response.object().value("response").toObject();
        const auto materialsList = data.value("materials").toArray();
        const auto topcicsList = data.value("topics").toArray();

        QList<Material*> materials; materials.reserve(data.size());
        for (const auto& material : topcicsList){
            materials.emplaceBack(new Material(material.toObject()));
        }

        QList<Book*> topics; topics.reserve(data.size());
        for (const auto& topic : materialsList){
            topics.emplaceBack(new Book(topic.toObject()));
        }

        emit Admin::searchResults(materials,topics,materials.size(),topics.size());
    }
    else if (code == 400){
        //to do error handling
    }

}

void Admin::onIsLoggedInChanged()
{
    if (this->loggedIn){
        QUrlQuery query({{QString("email"),this->email.c_str()}});
        QUrl url(Endpoints::findStudentByEmail);
        url.setQuery(query);
        QNetworkRequest request(url);
        request.setRawHeader(QByteArray("Authorization"), QString("Bearer %1").arg(this->idToken.c_str()).toUtf8());
        this->setIsRunning(true);
        const auto reply = this->manager->get(request);
        QObject::connect(reply,&QNetworkReply::finished,this,[reply,this](){
            if (reply){
                this->findUserResponse(QJsonDocument::fromJson(reply->readAll()));
                reply->deleteLater();
            }
            this->setIsRunning(false);
        });
    }
}

Admin::Admin(QObject * parent) :
    QObject{parent},
    manager(std::make_unique<QNetworkAccessManager>(this)),
    idToken(""),
    email(""),
    refreshToken(""),
    loggedIn(false),
    running(false),
    student_ptr(nullptr)
{
    QObject::connect(this,&Admin::isLoggedInChanged,this,&Admin::onIsLoggedInChanged);
}

const bool &Admin::isLoggedIn() const
{
    return this->loggedIn;
}

const bool &Admin::isRunning() const
{
    return this->running;
}

const QStringList &Admin::favorites() const
{
    return this->student_ptr->favorites();
}

Student * Admin::stud() const
{
    return this->student_ptr.get();
}

void Admin::signUp(QObject * const loginForm)
{
    const QUrl url(Endpoints::signUp);
    const auto payload = static_cast<QVariantMap>(this->QObjectPropertiesToMap(loginForm,this->signUpProperties()));
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    this->setIsRunning(true);
    const auto reply = this->manager->post(request,QJsonDocument::fromVariant(payload).toJson());
    QObject::connect(reply,&QNetworkReply::finished,this,[reply,this](){
        if (reply){
            this->signUpResponse(QJsonDocument::fromJson(reply->readAll()));
            reply->deleteLater();
        }
        this->setIsRunning(false);
    });
}

void Admin::signIn(QObject * const signInForm)
{
    const QUrl url(Endpoints::login);
    const auto payload = static_cast<QVariantMap>(this->QObjectPropertiesToMap(signInForm,this->signInProperties()));
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    this->setIsRunning(true);
    const auto reply = this->manager->post(request,QJsonDocument::fromVariant(payload).toJson());
    QObject::connect(reply,&QNetworkReply::finished,this,[reply,this](){
        if (reply){
            this->signInResponse(QJsonDocument::fromJson(reply->readAll()));
            reply->deleteLater();
        }
        this->setIsRunning(false);
    });
}

void Admin::fetchMaterialsList()
{
    const QUrl url(Endpoints::materialList);
    QNetworkRequest request(url);
    request.setRawHeader(QByteArray("Authorization"), QString("Bearer %1").arg(this->idToken.c_str()).toUtf8());
    this->setIsRunning(true);
    const auto reply = this->manager->get(request);
    QObject::connect(reply,&QNetworkReply::finished,this,[reply,this](){
        if (reply){
            this->materialListResponse(QJsonDocument::fromJson(reply->readAll()));
            reply->deleteLater();
        }
        this->setIsRunning(false);
    });
}

void Admin::fetchBooksFor(const QString materialId)
{
    QUrlQuery query({{QString("materialId"),materialId}});
    QUrl url(Endpoints::topicsFor);
    url.setQuery(query);
    QNetworkRequest request(url);
    request.setRawHeader(QByteArray("Authorization"), QString("Bearer %1").arg(this->idToken.c_str()).toUtf8());
    this->setIsRunning(true);
    const auto reply = this->manager->get(request);
    QObject::connect(reply,&QNetworkReply::finished,this,[reply,this](){
        if (reply){
            this->topicsForResponse(QJsonDocument::fromJson(reply->readAll()));
            reply->deleteLater();
        }
        this->setIsRunning(false);
    });
}

void Admin::updateFavorites(const QString topicId)
{
    QUrlQuery query({
                        {QString("topicId"),topicId},
                        {QString("studentId"),this->student_ptr->id()}
                    });
    QUrl url(Endpoints::favorite);
    url.setQuery(query);
    QNetworkRequest request(url);
    request.setRawHeader(QByteArray("Authorization"), QString("Bearer %1").arg(this->idToken.c_str()).toUtf8());
    this->setIsRunning(true);
    const auto reply = this->manager->get(request);
    QObject::connect(reply,&QNetworkReply::finished,this,[reply,this](){
        if (reply){
            this->favoriteResponse(QJsonDocument::fromJson(reply->readAll()));
            reply->deleteLater();
        }
        this->setIsRunning(false);
    });
}

Student * const Admin::getStudent() const
{
    return this->student_ptr.get();
}

void Admin::updateStudent(QObject * const student)
{
    student->setProperty("idToken",this->idToken.c_str());
    student->setProperty("studentId",this->student_ptr->id());
    student->setProperty("returnSecureToken",true);
    QUrl url(Endpoints::updateStudent);
    const auto payload = static_cast<QVariantMap>(this->QObjectPropertiesToMap(student,this->updateStudentProperties()));
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    request.setRawHeader(QByteArray("Authorization"), QString("Bearer %1").arg(this->idToken.c_str()).toUtf8());
    this->setIsRunning(true);
    const auto reply = this->manager->post(request,QJsonDocument::fromVariant(payload).toJson());
    QObject::connect(reply,&QNetworkReply::finished,this,[reply,this](){
        if (reply){
            this->findUserResponse(QJsonDocument::fromJson(reply->readAll()));
            reply->deleteLater();
        }
        this->setIsRunning(false);
    });
}

void Admin::searchByText(const QString &searchText)
{
    QUrlQuery query({
                        {QString("searchText"),searchText},
                    });
    QUrl url(Endpoints::searchByText);
    url.setQuery(query);
    QNetworkRequest request(url);
    request.setRawHeader(QByteArray("Authorization"), QString("Bearer %1").arg(this->idToken.c_str()).toUtf8());
    this->setIsRunning(true);
    const auto reply = this->manager->get(request);
    QObject::connect(reply,&QNetworkReply::finished,this,[reply,this](){
        if (reply){
            this->searchByTextResponse(QJsonDocument::fromJson(reply->readAll()));
            reply->deleteLater();
        }
        this->setIsRunning(false);
    });
}

void Admin::setIsLoggedIn(const bool &loggedIn)
{
    if (this->loggedIn != loggedIn){
        this->loggedIn = loggedIn;
        emit Admin::isLoggedInChanged();
    }
}

void Admin::setIsRunning(const bool &running)
{
    if (this->running != running){
        this->running = running;
        emit Admin::isRunningChanged();
    }
}

void Admin::setFavorites(const QStringList &favorites)
{
    if (this->student_ptr->favorites() != favorites){
        this->student_ptr->setFavorites(favorites);
        emit Admin::favoritesChanged();
    }
}

void Admin::setStud(Student *stud)
{
    if (stud){
        this->student_ptr = std::make_unique<Student>(stud->getObject(),this);
        emit Admin::studChanged();
    }
}
