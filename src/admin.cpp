#include "admin.h"


Admin::Admin(QObject *parent)
    : Request{parent},
      m_isLoggedIn(false)
{
    this->connectResponseToAdminSignals(this->getResponse());
}

void Admin::onSignInReady()
{
    this->setIsLoggedIn(true);
}

void Admin::onSignInError(const QString msg)
{
    emit Admin::displayErrorMessage(msg);
}

const bool Admin::isLoggedIn() const
{
    return this->m_isLoggedIn;
}

const QVariantMap Admin::userProfile() const
{
    return this->getResponse()->getUser()->user.toVariantMap();
}

void Admin::connectResponseToAdminSignals(Response * const response)
{
    QObject::connect(response,&Response::signInReady,this,&Admin::onSignInReady);
    QObject::connect(response,&Response::signInError,this,&Admin::onSignInError);
    QObject::connect(response,&Response::coursesList,this,&Admin::courseList);
    QObject::connect(response,&Response::courseSyllabusList,this,[this](const QJsonArray syllabuses){
        emit Admin::courseSyllabuses(syllabuses);
    });
}

void Admin::setIsLoggedIn(const bool &isLoggedIn)
{
    if (this->m_isLoggedIn != isLoggedIn){
        this->m_isLoggedIn = isLoggedIn;
        emit Admin::isLoggedInChanged();
    }
}

void Admin::setUserProfile(const QVariantMap map)
{

}
