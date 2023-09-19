#include "operations.h"

Operations::Operations()
{

}

const QJsonObject Operations::buildVariables(const QStringList &keys, QObject * const properties) const
{
    QJsonObject variables;
    for (const auto& key :keys){
        variables.insert(key,properties->property(key.toStdString().c_str()).toJsonValue());
    }
    return variables;
}

const QStringList &Operations::getCreateUserKeys() const
{
    return this->createUserKeys;
}

const QStringList &Operations::getSignInKeys() const
{
    return this->signInKeys;
}

const QJsonDocument Operations::createDocument(const char *query, const QJsonObject &variables) const
{
    QJsonObject jsonObject;
    jsonObject.insert("query",query);
    jsonObject.insert("variables",variables);
    return QJsonDocument(jsonObject);
}
