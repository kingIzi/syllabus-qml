#pragma once
#include <QObject>
#include <QModelIndex>
#include "response.h"

class CourseListData : public QObject
{
    Q_OBJECT
private:
    QList<Course> courses;
public:
    explicit CourseListData(const QJsonArray& courses,QObject * parent = nullptr);
    explicit CourseListData(QObject * parent = nullptr);
    void setCourses(const QList<Course>& courses);
    const QList<Course>& getCourses() const;
    const bool setItemAt(const int index,const Course& course);
public slots:
    void addCourse(const Course& course);
signals:
    void preItemAppended();
    void postItemAppended();
    void preItemRemoved(QModelIndex index);
    void postItemRemoved();
};

