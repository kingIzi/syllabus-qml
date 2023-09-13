#include "booklistdata.h"

BookListData::BookListData(QObject * parent) :
    QObject{parent}
{

}

BookListData::~BookListData()
{

}

void BookListData::setBooks(const QList<Book *> books)
{
    if (this->books != books){
        this->books = books;
    }
}

const QList<Book *> BookListData::getBooks() const
{
    return this->books;
}

void BookListData::setItemAt(Book *book, const QModelIndex index)
{
    if (!index.isValid()) { return; }
    const auto current = this->books.at(index.row());
    if (current == book) { return; }
    emit BookListData::preItemAppended();
    this->books.insert(index.row(),book);
    emit BookListData::postItemAppended();
}

void BookListData::addItem(Book *book)
{
    emit BookListData::preItemAppended();
    this->books.emplaceBack(book);
    emit BookListData::postItemAppended();
}
