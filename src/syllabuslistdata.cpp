#include "syllabuslistdata.h"

SyllabusListData::SyllabusListData(const QJsonArray &syllabuses, QObject *parent) :
    QObject{parent}
{
    this->syllabuses.reserve(syllabuses.size());
    for (const auto& item : syllabuses){
        this->syllabuses.emplaceBack(Syllabus(item.toObject()));
    }
}

SyllabusListData::SyllabusListData(QObject *parent)
    : QObject{parent}
{

}

void SyllabusListData::setSyllabuses(const QList<Syllabus> &syllabuses)
{
    if (this->syllabuses != syllabuses){
        this->syllabuses = syllabuses;
    }
}

const QList<Syllabus> &SyllabusListData::getSyllabuses() const
{
    return this->syllabuses;
}

const bool SyllabusListData::setItemAt(const int index, const Syllabus &syllabus)
{
    if (index < 0 || index >= this->syllabuses.size()) return false;
    const auto& oldItem = this->syllabuses.at(index);
    if (oldItem == syllabus) return false;
    this->syllabuses.replace(index,syllabus);
    return true;
}

void SyllabusListData::addSyllabus(const Syllabus &syllabus)
{
    emit SyllabusListData::preItemAppended();
    this->syllabuses.emplaceBack(syllabus);
    emit SyllabusListData::postItemAppended();
}
