#ifndef PAGESMODEL_H
#define PAGESMODEL_H

#include <QObject>
#include <QQmlEngine>
#include <MauiKit/Core/mauilist.h>

class QObject;
class PagesModel : public MauiList
{
    Q_OBJECT
public:
    explicit PagesModel(QObject *parent = nullptr);

    const FMH::MODEL_LIST &items() const override final;
private:
    /**
     * There is the list that holds the conatcts data,
     * and the list-bk which holds a cached version of the list,
     * this helps to not have to fecth contents all over again
     * when filtering the list
     */
    QVariantList m_canvas;
    FMH::MODEL_LIST list;
    QQmlEngine qmlEngine;

signals:
    void ready();

public slots:
    bool remove(const int &index);
    bool add(const QVariantMap &map);
    
    bool linkPage(QVariant canvas);

    void clear();
    QVariant getPage(int index);
    int count();
};

#endif // PAGESLIST_H

