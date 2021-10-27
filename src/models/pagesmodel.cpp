#include "pagesmodel.h"
//#include "abstractinterface.h"

#include <QDebug>
/*
#ifdef Q_OS_ANDROID
#include "androidinterface.h"
#else
#include "linuxinterface.h"
#endif
*/
#include <MauiKit/Core/fmh.h>
/*
#ifdef Q_OS_ANDROID
PagesModel::PagesModel(QObject *parent)
    : MauiList(parent)
    , syncer(AndroidInterface::getInstance())
#else
PagesModel::PagesModel(QObject *parent)
    : MauiList(parent)
    , syncer(new LinuxInterface(this))
#endif
{
    connect(syncer, &AbstractInterface::pagesReady, [this](FMH::MODEL_LIST pages) {
        qDebug() << "CONATCTS READY AT MODEL 1" << pages;
        emit this->preListChanged();
        this->list = pages;
        this->filter();
        emit this->postListChanged();
        emit this->countChanged();
    });

    this->getList();
}
*/

PagesModel::PagesModel(QObject *parent)
    : MauiList(parent)
{

/*
    connect(syncer, &AbstractInterface::pagesReady, [this](FMH::MODEL_LIST pages) {
        qDebug() << "CONATCTS READY AT MODEL 1" << pages;
        emit this->preListChanged();
        this->list = pages;
        this->filter();
        emit this->postListChanged();
        emit this->countChanged();
    });
*/
    emit this->ready();

}

const FMH::MODEL_LIST &PagesModel::items() const
{
    return this->list;
}

/*
void PagesModel::getList()
{
    qDebug() << "TRYING TO SET FULL LIST";
    this->syncer->getPages();
}
*/
bool PagesModel::insert(const QVariantMap &map)
{
    qDebug() << "INSERTING NEW PAGE" << map;

    const auto model = FMH::toModel(map);
//    if (!this->syncer->insertPage(model))
//        return false;

    qDebug() << "inserting new page count" << this->list.count();
    emit this->preItemAppended();
    this->list << model;
    emit this->postItemAppended();

    qDebug() << "inserting new page count" << this->list.count();
    emit this->countChanged();

    return true;
}

bool PagesModel::update(const QVariantMap &map, const int &index)
{
    if (index >= this->list.size() || index < 0)
        return false;

    const auto newItem = FMH::toModel(map);
    const auto oldItem = this->list[index];

    auto updatedItem = FMH::MODEL();
    updatedItem[FMH::MODEL_KEY::ID] = oldItem[FMH::MODEL_KEY::ID];

    QVector<int> roles;
    for (const auto &key : newItem.keys()) {
        if (newItem[key] != oldItem[key]) {
            updatedItem.insert(key, newItem[key]);
            roles << key;
        }
    }

    qDebug() << "trying to update page:" << oldItem << "\n\n" << newItem << "\n\n" << updatedItem;

//    this->syncer->updatePage(oldItem[FMH::MODEL_KEY::ID], newItem);
    this->list[index] = newItem;
    emit this->updateModel(index, roles);

    return true;
}

bool PagesModel::remove(const int &index)
{
    if (index >= this->list.size() || index < 0)
        return false;

    qDebug() << "trying to remove :" << this->list[index][FMH::MODEL_KEY::ID];
    emit this->preItemRemoved(index);
    this->list.removeAt(index);
    emit this->postItemRemoved();
    return true;

    return false;
}
/*
void PagesModel::filter()
{
    FMH::MODEL_LIST res;

    if (this->m_query.contains("=")) {
        auto q = this->m_query.split("=", Qt::SkipEmptyParts);
        if (q.size() == 2) {
            for (auto item : this->list) {
                if (item[FMH::MODEL_NAME_KEY[q.first().trimmed()]].replace(" ", "").contains(q.last().trimmed()))
                    res << item;
            }
        }

        this->list = res;
    }
}
*/
void PagesModel::append(const QVariantMap &item)
{

    emit this->preItemAppended();

    FMH::MODEL model;
    for (auto key : item.keys())
        model.insert(FMH::MODEL_NAME_KEY[key], item[key].toString());

    qDebug() << "Appending item to list" << item;

    this->list << model;
    //printf("%d\n", this->list.count());

    qDebug() << this->list;

    emit this->postItemAppended();
}

void PagesModel::append(const QVariantMap &item, const int &at)
{

    if (at > this->list.size() || at < 0)
        return;

    qDebug() << "trying to append at" << at << item["title"];

    emit this->preItemAppendedAt(at);
    this->list.insert(at, FMH::toModel(item));
    emit this->postItemAppended();
}

void PagesModel::clear()
{
    emit this->preListChanged();
    this->list.clear();
    emit this->postListChanged();
}

void PagesModel::refresh()
{
    this->items();
}

QVariantList PagesModel::getPages()
{
    return FMH::toMapList(FMH::MODEL_LIST());
}
