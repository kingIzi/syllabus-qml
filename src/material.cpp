#include "material.h"

Material::Material(QObject * parent) :
    QObject{parent}
{

}

Material::Material(const QJsonObject &material, QObject *parent) :
    QObject{parent},
    id_m(material.value("id").toString()),title_m(material.value("title").toString()),
    thumbnail_m(material.value("thumbnail").toString())
{

}

const QString &Material::id() const
{
    return this->id_m;
}

const QString &Material::title() const
{
    return this->title_m;
}

const QString &Material::thumbnail() const
{
    return this->thumbnail_m;
}

void Material::setId(const QString &id)
{
    if (this->id_m.compare(id) != 0){
        this->id_m = id;
        emit Material::idChanged();
    }
}

void Material::setTitle(const QString &title)
{
    if (this->title_m.compare(title) != 0){
        this->title_m = title;
        emit Material::titleChanged();
    }
}

void Material::setThumbnail(const QString &thumbnail)
{
    if (this->thumbnail_m.compare(thumbnail)){
        this->thumbnail_m = thumbnail;
        emit Material::thumbnailChanged();
    }
}
