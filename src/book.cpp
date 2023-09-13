#include "book.h"

Book::Book(QObject *parent)
    : QObject{parent}
{

}

Book::Book(const QJsonObject &book, QObject *parent) :
    QObject{parent},author_m(book.value("author").toString()),
    summary_m(book.value("summary").toString()),id_m(book.value("id").toString()),
    thumbnail_m(book.value("thumbnail").toString()),
    dataUrl_m(book.value("datUrl").toString()),level_m((qint8) book.value("level").toInt()),
    published_m(book.value("published").toVariant().toDateTime()),
    authorId_m(book.value("authorId").toString()),title_m(book.value("title").toString()),
    languages_m(book.value("languages").toVariant().toStringList())
{

}

const QString &Book::summary() const
{
    return this->summary_m;
}

const QString &Book::id() const
{
    return this->id_m;
}

const QString &Book::thumbnail() const
{
    return this->thumbnail_m;
}

const QString &Book::dataUrl() const
{
    return this->dataUrl_m;
}

const qint8 &Book::level() const
{
    return this->level_m;
}

const QDateTime &Book::published() const
{
    return this->published_m;
}

const QString &Book::authorId() const
{
    return this->authorId_m;
}

const QString &Book::title() const
{
    return this->title_m;
}

const QStringList &Book::languages() const
{
    return this->languages_m;
}

const QString &Book::author() const
{
    return this->author_m;
}

void Book::setSummary(const QString &summary)
{
    if (this->summary_m != summary){
        this->summary_m = summary;
        emit Book::summaryChanged();
    }
}

void Book::setId(const QString &id)
{
    if (this->id_m != id){
        this->id_m = id;
        emit Book::idChanged();
    }
}

void Book::setThumbnail(const QString &thumbnail)
{
    if (this->thumbnail_m != thumbnail){
        this->thumbnail_m = thumbnail;
        emit Book::thumbnailChanged();
    }
}

void Book::setDataUrl(const QString &dataUrl)
{
    if (this->dataUrl_m != dataUrl){
        this->dataUrl_m = dataUrl;
        emit Book::dataUrlChanged();
    }
}

void Book::setLevel(const qint8 &level)
{
    if (this->level_m != level){
        this->level_m = level;
        emit Book::levelChanged();
    }
}

void Book::setPublished(const QDateTime &published)
{
    if (this->published_m != published){
        this->published_m = published;
        emit Book::publishedChanged();
    }
}

void Book::setAuthorId(const QString &authorId)
{
    if (this->authorId_m != authorId){
        this->authorId_m = authorId;
        emit Book::authorIdChanged();
    }
}

void Book::setTitle(const QString &title)
{
    if (this->title_m != title){
        this->title_m = title;
        emit Book::titleChanged();
    }
}

void Book::setLanguages(const QStringList &languages)
{
    if (this->languages_m != languages){
        this->languages_m = languages;
        emit Book::languagesChanged();
    }
}

void Book::setAuthor(const QString &author)
{
    if (this->author_m != author){
        this->author_m = author;
        emit Book::authorChanged();
    }
}
