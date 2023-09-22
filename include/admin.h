#pragma once
#include <QObject>
#include "request.h"

class Admin : public Request
{
    Q_OBJECT
    Q_PROPERTY(bool isLoggedIn READ isLoggedIn WRITE setIsLoggedIn NOTIFY isLoggedInChanged)
    Q_PROPERTY(QVariantMap userProfile READ userProfile WRITE setUserProfile NOTIFY userProfileChanged)
private:
    bool m_isLoggedIn;
public:
    explicit Admin(QObject *parent = nullptr);
    const bool isLoggedIn() const;
    const QVariantMap userProfile() const;
private:
    void connectResponseToAdminSignals(Response * const response);
private slots:
    void onSignInReady();
    void onSignInError(const QString msg);
public slots:
    void setIsLoggedIn(const bool& isLoggedIn);
    void setUserProfile(const QVariantMap map);
signals:
    void isLoggedInChanged();
    void displayErrorMessage(const QString);
    void courseList(const QJsonArray,const QString);
    void courseSyllabuses(const QJsonArray);
    void userProfileChanged();
};

