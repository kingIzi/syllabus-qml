#include "syllabuslistmodel.h"

void SyllabusListModel::populateSignals()
{
    if (this->syllabusListData_ptr){
        QObject::connect(this->syllabusListData_ptr.get(),&SyllabusListData::postItemAppended,this,[this](){
            const auto index = this->syllabusListData_ptr->getSyllabuses().size();
            this->beginInsertRows(QModelIndex(),index,index);
        });
        QObject::connect(this->syllabusListData_ptr.get(),&SyllabusListData::postItemAppended,this,[this](){
            this->endInsertRows();
        });
        QObject::connect(this->syllabusListData_ptr.get(),&SyllabusListData::preItemRemoved,this,[this](QModelIndex index){
            this->beginRemoveRows(QModelIndex(),index.row(),index.row());
        });
        QObject::connect(this->syllabusListData_ptr.get(),&SyllabusListData::postItemRemoved,this,[this](){
            this->endRemoveRows();
        });
    }
}

void SyllabusListModel::onPopulate(const QJsonArray syllabuses)
{
    if (syllabuses.empty()) { return; }
    this->beginResetModel();
    this->syllabusListData_ptr->disconnect(this);
    this->syllabusListData_ptr = std::make_unique<SyllabusListData>(syllabuses);
    this->populateSignals();
    this->endResetModel();
}

SyllabusListModel::SyllabusListModel(QAbstractListModel * parent) :
    QAbstractListModel{parent},
    syllabusListData_ptr(nullptr)
{
    QObject::connect(this,&SyllabusListModel::populate,this,&SyllabusListModel::onPopulate);
}

SyllabusListModel::~SyllabusListModel()
{

}

SyllabusListData *SyllabusListModel::syllabusListData() const
{
    return this->syllabusListData_ptr.get();
}

int SyllabusListModel::rowCount(const QModelIndex & index) const
{
    if (index.isValid() || !this->syllabusListData_ptr)
        return 0;
    return this->syllabusListData_ptr->getSyllabuses().size();
}

QVariant SyllabusListModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || !this->syllabusListData_ptr)
        return QVariant();
    const auto syllabus = this->syllabusListData_ptr->getSyllabuses().at(index.row());
    switch (role){
    case ID:
        return syllabus.id;
    case NAME:
        return syllabus.name;
    case AUTHOR:
        return syllabus.author.toMap().value("name").toString();
    case UNIVERSITIES:
        return syllabus.university;
    case THUMBNAIL:
        return syllabus.thumbnail;
    case YEAR_GROUP:
        return syllabus.yearGroup;
    case LANGUAGES:
        return syllabus.languages;
    case LESSONS:
        return syllabus.lessons;
    default:
        return QVariant();
    }
    return QVariant();
}

QHash<int, QByteArray> SyllabusListModel::roleNames() const
{
    return {
        {ID,"syllabusId"},
        {NAME,"syllabusName"},
        {AUTHOR,"syllabusAuthor"},
        {UNIVERSITIES,"syllabusUniversities"},
        {THUMBNAIL,"thumbnail"},
        {YEAR_GROUP,"yearGroup"},
        {LANGUAGES,"languages"},
        {LESSONS,"lessons"}
    };
}

void SyllabusListModel::setSyllabusListData(SyllabusListData *syllabusListData_ptr)
{
    emit SyllabusListModel::syllabusListDataChanged();
}
