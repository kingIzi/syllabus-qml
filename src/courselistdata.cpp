#include "courselistdata.h"

CourseListData::CourseListData(const QJsonArray& courses,QObject * parent) :
    QObject{parent}
{
    this->courses.reserve(courses.size());
    for (const auto& item : courses){
        this->courses.emplaceBack(Course(item.toObject()));
    }
}

CourseListData::CourseListData(QObject *parent) :
    QObject{parent}
{

}

void CourseListData::setCourses(const QList<Course> &courses)
{
    if (this->courses != courses){
        this->courses = courses;
    }
}

const QList<Course> &CourseListData::getCourses() const
{
    return this->courses;
}

const bool CourseListData::setItemAt(const int index, const Course &course)
{
    if (index < 0 || index >= this->courses.size()) return false;
    const auto& oldItem = this->courses.at(index);
    if (oldItem == course) return false;
    this->courses.replace(index,course);
    return true;
}

void CourseListData::addCourse(const Course &course)
{
    emit CourseListData::preItemAppended();
    this->courses.emplaceBack(course);
    emit CourseListData::postItemAppended();
}
