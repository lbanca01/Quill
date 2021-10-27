#ifndef PAGESMODEL_H
#define PAGESMODEL_H

#include <QObject>

#include <MauiKit/Core/mauilist.h>

class QObject;
class PagesModel : public MauiList
{
    Q_OBJECT

public:
    explicit PagesModel(QObject *parent = nullptr);

    const FMH::MODEL_LIST &items() const override final;
private:
    /*
     * *syncer (abstract interface) should work with whatever interface derived from
     * AbstractInterface, for now we have Android and Linux interfaces
     */

    //AbstractInterface *syncer;

    /**
     * There is the list that holds the conatcts data,
     * and the list-bk which holds a cached version of the list,
     * this helps to not have to fecth contents all over again
     * when filtering the list
     */
    FMH::MODEL_LIST list;

    /**
     * query is a property to start filtering the list, the filtering is
     * done over the list-bk cached list instead of the main list
     */

signals:
    void ready();

public slots:
    bool insert(const QVariantMap &map);
    bool update(const QVariantMap &map, const int &index);
    bool remove(const int &index);

    void append(const QVariantMap &item, const int &at);
    void append(const QVariantMap &item);

    void clear();
    void refresh();
    QVariantList getPages();
};

#endif // PAGESLIST_H

