#pragma once
#include <QAbstractListModel>
#include "syllabuslistdata.h"

class SyllabusListModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(SyllabusListData* syllabusListData READ syllabusListData WRITE setSyllabusListData NOTIFY syllabusListDataChanged)
private:
    std::unique_ptr<SyllabusListData> syllabusListData_ptr;
private:
    void populateSignals();
private slots:
    void onPopulate(const QJsonArray syllabuses);
public:
    enum {
        ID = Qt::UserRole,NAME,AUTHOR,UNIVERSITIES,THUMBNAIL,YEAR_GROUP,LANGUAGES,LESSONS
    };
public:
    explicit SyllabusListModel(QAbstractListModel * parent = nullptr);
    ~SyllabusListModel();
    SyllabusListData* syllabusListData() const;
    int rowCount(const QModelIndex & = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;
public slots:
    void setSyllabusListData(SyllabusListData* syllabusListData_ptr);
signals:
    void syllabusListDataChanged();
    void populate(const QJsonArray);
};

