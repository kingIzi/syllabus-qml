#pragma once
#include <QObject>
#include <QModelIndex>
#include "book.h"

class BookListData : public QObject
{
    Q_OBJECT
private:
    QList<Book*> books;
public:
    explicit BookListData(QObject * parent = nullptr);
    ~BookListData();
    void setBooks(const QList<Book*> books);
    const QList<Book*> getBooks() const;
    void setItemAt(Book* material,const QModelIndex index);
    void addItem(Book* material);
signals:
    void preItemAppended();
    void postItemAppended();
    void preItemRemoved(const QModelIndex&);
    void postItemRemoved();
};

