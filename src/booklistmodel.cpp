#include "booklistmodel.h"

BookListModel::BookListModel(QAbstractListModel * parent) :
    QAbstractListModel{parent}
{
    this->bookListData_m = new BookListData();
    QObject::connect(this,&BookListModel::populate,this,&BookListModel::onPopulate);
}

BookListModel::~BookListModel()
{
    this->bookListData_m->deleteLater();
}

BookListData *BookListModel::bookListData() const
{
    return this->bookListData_m;
}

int BookListModel::rowCount(const QModelIndex & index) const
{
    if (index.isValid() || !this->bookListData_m)
        return 0;
    return this->bookListData_m->getBooks().size();
}

QVariant BookListModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || !this->bookListData_m)
        return QVariant();
    const auto& book = this->bookListData_m->getBooks().at(index.row());
    switch (role){
    case ID:
        return book->id();
    case TITLE:
        return book->title();
    case THUMBNAIL:
        return book->thumbnail();
    case SUMMARY:
        return book->summary();
    case DATA_URL:
        return book->dataUrl();
    case LEVEL:
        return book->level();
    case AUTHOR_ID:
        return book->authorId();
    case LANGUAGES:
        return book->languages();
    case PUBLISHED:
        return book->published().toString("dd MMM yyyy");
    case AUTHOR:
        return book->author();
    default:
        break;
    }
    return QVariant();
}

QHash<int, QByteArray> BookListModel::roleNames() const
{
    return {
        {ID,"id"},
        {TITLE,"title"},
        {THUMBNAIL,"thumbnail"},
        {DATA_URL,"dataUrl"},
        {PUBLISHED,"published"},
        {SUMMARY,"summary"},
        {LEVEL,"level"},
        {AUTHOR_ID,"authorId"},
        {LANGUAGES,"languages"},
        {AUTHOR,"author"}
    };
}

void BookListModel::populateList()
{
    if (this->bookListData_m){
        QObject::connect(this->bookListData_m,&BookListData::postItemAppended,this,[this](){
            const auto index = this->bookListData_m->getBooks().size();
            this->beginInsertRows(QModelIndex(),index,index);
        });
        QObject::connect(this->bookListData_m,&BookListData::postItemAppended,this,[this](){
            this->endInsertRows();
        });
        QObject::connect(this->bookListData_m,&BookListData::preItemRemoved,this,[this](QModelIndex index){
            this->beginRemoveRows(QModelIndex(),index.row(),index.row());
        });
        QObject::connect(this->bookListData_m,&BookListData::postItemRemoved,this,[this](){
            this->endRemoveRows();
        });
    }
}

void BookListModel::onPopulate(const QList<Book *>& books)
{
    if (!books.isEmpty()) {
        this->beginResetModel();
        this->bookListData_m->setBooks(books);
        this->populateList();
        this->endResetModel();
    }
}

void BookListModel::setBookListData(BookListData *bookList)
{
    if (this->bookListData_m != bookList){
        this->bookListData_m = bookList;
        emit BookListModel::bookListDataChanged();
    }
}
