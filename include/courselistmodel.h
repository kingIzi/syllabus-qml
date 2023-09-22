#pragma once
#include <QObject>
#include <QAbstractListModel>
#include <memory>
#include <QModelIndex>
#include "courselistdata.h"

class CourseListModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(CourseListData* courseListData READ courseListData WRITE setCourseListData NOTIFY courseListDataChanged)
private:
    std::unique_ptr<CourseListData> courseListData_ptr;
private:
    void populateSignals();
private slots:
    void onPopulate(const QJsonArray& courses);
public:
    enum {
        ID = Qt::UserRole,NAME,NUM_SYLLABUS,THUMBNAIL
    };
public:
    explicit CourseListModel(QAbstractListModel *parent = nullptr);
    ~CourseListModel();
    int rowCount(const QModelIndex & = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;
    CourseListData* courseListData() const;
    void setCourseListData(CourseListData* courseList);
signals:
    void populate(const QJsonArray);
    void courseListDataChanged();
};

