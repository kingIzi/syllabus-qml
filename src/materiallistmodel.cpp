#include "materiallistmodel.h"

MaterialListModel::MaterialListModel(QAbstractListModel* parent) :
    QAbstractListModel{parent}
{
    this->m_materialsListData = new MaterialListData();
    QObject::connect(this,&MaterialListModel::populate,this,&MaterialListModel::onPopulate);
}

MaterialListModel::~MaterialListModel()
{
    this->m_materialsListData->deleteLater();
}

MaterialListData * const MaterialListModel::materialListData() const
{
    return this->m_materialsListData;
}

int MaterialListModel::rowCount(const QModelIndex & index) const
{
    if (index.isValid() || !this->m_materialsListData)
        return 0;
    return this->m_materialsListData->getMaterials().size();
}

QVariant MaterialListModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || !this->m_materialsListData)
        return QVariant();
    const auto& material = this->m_materialsListData->getMaterials().at(index.row());
    switch (role){
    case ID:
        return material->id();
    case TITLE:
        return material->title();
    case THUMBNAIL:
        return material->thumbnail();
    default:
        break;
    }
    return QVariant();
}

QHash<int, QByteArray> MaterialListModel::roleNames() const
{
    return {
        {ID,"id"},
        {TITLE,"title"},
        {THUMBNAIL,"thumbnail"},
    };
}

void MaterialListModel::populateList()
{
    if (this->m_materialsListData){
        QObject::connect(this->m_materialsListData,&MaterialListData::postItemAppended,this,[this](){
            const auto index = this->m_materialsListData->getMaterials().size();
            this->beginInsertRows(QModelIndex(),index,index);
        });
        QObject::connect(this->m_materialsListData,&MaterialListData::postItemAppended,this,[this](){
            this->endInsertRows();
        });
        QObject::connect(this->m_materialsListData,&MaterialListData::preItemRemoved,this,[this](QModelIndex index){
            this->beginRemoveRows(QModelIndex(),index.row(),index.row());
        });
        QObject::connect(this->m_materialsListData,&MaterialListData::postItemRemoved,this,[this](){
            this->endRemoveRows();
        });
    }
}

void MaterialListModel::onPopulate(const QList<Material*> &materials)
{
    if (!materials.isEmpty()) {
        this->beginResetModel();
        this->m_materialsListData->setMaterials(materials);
        this->populateList();
        this->endResetModel();
    }
}

void MaterialListModel::setMaterialListData(MaterialListData *materialListData)
{
    this->m_materialsListData = materialListData;
    emit MaterialListModel::materialListDataChanged();
}

