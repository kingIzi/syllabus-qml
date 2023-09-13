#include "materiallistdata.h"

MaterialListData::MaterialListData(QObject * parent) :
    QObject{parent}
{

}

MaterialListData::MaterialListData(const QList<Material*> &materials, QObject *parent) :
    QObject{parent},
    materials(materials)
{

}

void MaterialListData::setMaterials(const QList<Material*> &materials)
{
    if (this->materials != materials){
        this->materials = materials;
    }
}

const QList<Material*> &MaterialListData::getMaterials() const
{
    return this->materials;
}

void MaterialListData::setItemAt(Material* material, const QModelIndex index)
{
    if (!index.isValid()) { return; }
    const auto current = this->materials.at(index.row());
    if (current == material) { return; }
    emit MaterialListData::preItemAppended();
    this->materials.insert(index.row(),material);
    emit MaterialListData::postItemAppended();
}

void MaterialListData::addItem(Material* material)
{
    emit MaterialListData::preItemAppended();
    this->materials.emplaceBack(material);
    emit MaterialListData::postItemAppended();
}

