#pragma once
#include <QObject>
#include <QAbstractListModel>
#include "booklistdata.h"


class BookListModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(BookListData* bookListData READ bookListData WRITE setBookListData NOTIFY bookListDataChanged)
private:
    BookListData* bookListData_m;
public:
    explicit BookListModel(QAbstractListModel * parent = nullptr);
    ~BookListModel();
public:
    enum {
        ID = Qt::UserRole,TITLE,THUMBNAIL,SUMMARY,LANGUAGES,LEVEL,DATA_URL,
        PUBLISHED,AUTHOR_ID,AUTHOR
    };
public:
    BookListData* bookListData() const;
    int rowCount(const QModelIndex & = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;
    void populateList();
private slots:
    void onPopulate(const QList<Book*>& books);
public slots:
    void setBookListData(BookListData* bookListData);
signals:
    void bookListDataChanged();
    void populate(const QList<Book*>&);
};

