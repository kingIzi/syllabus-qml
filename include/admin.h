#pragma once
#include <QObject>
#include <QDebug>
#include <memory>
#include <QNetworkAccessManager>
#include <QUrl>
#include <QList>
#include <QString>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include "student.h"
#include "materiallistmodel.h"
#include "booklistmodel.h"

class Admin : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool isLoggedIn READ isLoggedIn WRITE setIsLoggedIn NOTIFY isLoggedInChanged)
    Q_PROPERTY(bool isRunning READ isRunning WRITE setIsRunning NOTIFY isRunningChanged)
    Q_PROPERTY(QStringList favorites READ favorites WRITE setFavorites NOTIFY favoritesChanged)
    Q_PROPERTY(Student* stud READ stud WRITE setStud NOTIFY studChanged)
private:
    std::unique_ptr<QNetworkAccessManager> manager;
    std::string idToken;
    std::string refreshToken;
    std::string email;
    bool loggedIn;
    bool running;
    std::unique_ptr<Student> student_ptr;
private:
    struct Endpoints{
        static constexpr const char* baseUrl = "http://localhost";
        static constexpr const char* login = "http://localhost:8084/session/login";
        static constexpr const char* signUp = "http://localhost:8084/session/register";
        static constexpr const char* materialList = "http://localhost:8084/material/list";
        static constexpr const char* topicsFor = "http://localhost:8084/topic/for";
        static constexpr const char* findStudentByEmail = "http://localhost:8084/students/findByEmail";
        static constexpr const char* favorite = "http://localhost:8084/students/favorite";
        static constexpr const char* updateStudent = "http://localhost:8084/students/update";
        static constexpr const char* searchByText = "http://localhost:8084/topic/filterByTitle";
    };
private:
    std::map<QString, QVariant> QObjectPropertiesToMap(QObject *const object,const QStringList& propertyNames);
    const QStringList signUpProperties() const;
    const QStringList signInProperties() const;
    const QStringList updateStudentProperties() const;
    QUrl buildUrl(const char* path,const QList<QPair<QString,QString>> queries) const;
private: //responses
    void signUpResponse(const QJsonDocument);
    void signInResponse(const QJsonDocument);
    void materialListResponse(const QJsonDocument);
    void topicsForResponse(const QJsonDocument);
    void findUserResponse(const QJsonDocument);
    void favoriteResponse(const QJsonDocument);
    void updateUserResponse(const QJsonDocument);
    void searchByTextResponse(const QJsonDocument);
private slots:
    void onIsLoggedInChanged();
public:
    explicit Admin(QObject * parent = nullptr);
    const bool& isLoggedIn() const;
    const bool& isRunning() const;
    const QStringList& favorites() const;
    Student* stud() const;
public: //Q_INVOKABLE
    Q_INVOKABLE void signUp(QObject* const signUpForm);
    Q_INVOKABLE void signIn(QObject * const signInForm);
    Q_INVOKABLE void fetchMaterialsList();
    Q_INVOKABLE void fetchBooksFor(const QString materialId);
    Q_INVOKABLE void updateFavorites(const QString topicId);
    Q_INVOKABLE Student* const getStudent() const;
    Q_INVOKABLE void updateStudent(QObject *const parent);
    Q_INVOKABLE void searchByText(const QString& searchText);
signals:
    void isLoggedInChanged();
    void favoritesChanged();
    void signUpFailed(const QString);
    void isRunningChanged();
    void signInFailed(const QString);
    void materialList(const QList<Material*>);
    void topicsForList(const QList<Book*>);
    void studChanged();
    void searchResults(const QList<Material*>,const QList<Book*>,int,int);
public slots:
    void setIsLoggedIn(const bool& loggedIn);
    void setIsRunning(const bool& running);
    void setFavorites(const QStringList& favorites);
    void setStud(Student *stud);
};

