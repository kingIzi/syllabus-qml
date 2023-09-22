#pragma once
#include <QObject>
#include "response.h"

class SyllabusListData : public QObject
{
    Q_OBJECT
private:
    QList<Syllabus> syllabuses;
public:
    explicit SyllabusListData(const QJsonArray& syllabuses,QObject * parent = nullptr);
    explicit SyllabusListData(QObject *parent = nullptr);
    void setSyllabuses(const QList<Syllabus>& syllabuses);
    const QList<Syllabus>& getSyllabuses() const;
    const bool setItemAt(const int index,const Syllabus& syllabus);
public slots:
    void addSyllabus(const Syllabus& syllabus);
signals:
    void preItemAppended();
    void postItemAppended();
    void preItemRemoved(QModelIndex index);
    void postItemRemoved();
};

