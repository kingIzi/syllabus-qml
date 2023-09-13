#pragma once
#include <QObject>
#include <QAbstractListModel>
#include <memory>
#include "materiallistdata.h"

class MaterialListModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(MaterialListData* materialListData READ materialListData WRITE setMaterialListData NOTIFY materialListDataChanged)
private:
    MaterialListData* m_materialsListData;
public:
    enum {
        ID = Qt::UserRole,TITLE,THUMBNAIL
    };
public:
    explicit MaterialListModel(QAbstractListModel* parent = nullptr);
    ~MaterialListModel();
    MaterialListData* const materialListData() const;
    int rowCount(const QModelIndex & = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;
private:
    void populateList();
private slots:
    void onPopulate(const QList<Material*>& materials);
public slots:
    void setMaterialListData(MaterialListData* materialListData);
signals:
    void materialListDataChanged();
    void populate(const QList<Material*>& materials);
};

