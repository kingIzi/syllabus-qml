#include "courselistmodel.h"

void CourseListModel::populateSignals()
{
    if (this->courseListData_ptr){
        QObject::connect(this->courseListData_ptr.get(),&CourseListData::postItemAppended,this,[this](){
            const auto index = this->courseListData_ptr->getCourses().size();
            this->beginInsertRows(QModelIndex(),index,index);
        });
        QObject::connect(this->courseListData_ptr.get(),&CourseListData::postItemAppended,this,[this](){
            this->endInsertRows();
        });
        QObject::connect(this->courseListData_ptr.get(),&CourseListData::preItemRemoved,this,[this](QModelIndex index){
            this->beginRemoveRows(QModelIndex(),index.row(),index.row());
        });
        QObject::connect(this->courseListData_ptr.get(),&CourseListData::postItemRemoved,this,[this](){
            this->endRemoveRows();
        });
    }
}

void CourseListModel::onPopulate(const QJsonArray &courses)
{
    if (courses.empty()) { return; }
    this->beginResetModel();
    this->courseListData_ptr->disconnect(this);
    this->courseListData_ptr = std::make_unique<CourseListData>(courses);
    this->populateSignals();
    this->endResetModel();
}

CourseListModel::CourseListModel(QAbstractListModel *parent)
    : QAbstractListModel{parent},
      courseListData_ptr(nullptr)
{
    QObject::connect(this,&CourseListModel::populate,this,&CourseListModel::onPopulate);
}

CourseListModel::~CourseListModel()
{

}

int CourseListModel::rowCount(const QModelIndex & index) const
{
    if (index.isValid() || !this->courseListData_ptr)
        return 0;
    return this->courseListData_ptr->getCourses().size();
}

QVariant CourseListModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || !this->courseListData_ptr)
        return QVariant();
    const auto& course = this->courseListData_ptr->getCourses().at(index.row());
    switch (role){
    case ID:
        return course.id;
    case NAME:
        return course.name;
    case NUM_SYLLABUS:
        return course.numSyllabus;
    case THUMBNAIL:
        return course.thumbnail;
    default:
        return QVariant();
    }
    return QVariant();
}

QHash<int, QByteArray> CourseListModel::roleNames() const
{
    return {
        {ID,"courseId"},
        {NAME,"courseName"},
        {NUM_SYLLABUS,"numSyllabus"},
        {THUMBNAIL,"thumbnail"},
    };
}

CourseListData *CourseListModel::courseListData() const
{
    return this->courseListData_ptr.get();
}

void CourseListModel::setCourseListData(CourseListData *courseList)
{
    emit CourseListModel::courseListDataChanged();
}
