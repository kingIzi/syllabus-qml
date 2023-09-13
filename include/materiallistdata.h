#pragma once
#include <QObject>
#include <QList>
#include <QModelIndex>
#include <QJsonObject>

#include "material.h"

class MaterialListData : public QObject
{
    Q_OBJECT
private:
    QList<Material*> materials;
public:
    explicit MaterialListData(QObject * parent = nullptr);
    explicit MaterialListData(const QList<Material*>& materials,QObject *parent = nullptr);
    void setMaterials(const QList<Material*>& materials);
    const QList<Material*>& getMaterials() const;
    void setItemAt(Material* material,const QModelIndex index);
    void addItem(Material* material);
signals:
    void preItemAppended();
    void postItemAppended();
    void preItemRemoved(const QModelIndex&);
    void postItemRemoved();
};

