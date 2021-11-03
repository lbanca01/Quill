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

#include <iostream>

PagesModel::PagesModel(QObject *parent)
    : MauiList(parent)
{
    
    emit this->ready();
}

bool PagesModel::remove(const int &index)
{
    if (index >= this->list.size() || index < 0)
        return false;

    qDebug() << "trying to remove :" << this->list[index][FMH::MODEL_KEY::ID];
    emit this->preItemRemoved(index);
    this->m_canvas.removeAt(index);
    this->list.removeAt(index);
    emit this->postItemRemoved();
    return true;
}

bool PagesModel::add(const QVariantMap &map)
{
    qDebug() << "INSERTING NEW PAGE" << map;

    const auto model = FMH::toModel(map);

    qDebug() << "inserting new page count" << this->list.count();
    emit this->preItemAppended();
    this->list << model;
    emit this->postItemAppended();

    qDebug() << "inserting new page count" << this->list.count();

    return true;
}

const FMH::MODEL_LIST &PagesModel::items() const
{
    return this->list;
}

void PagesModel::clear()
{
    emit this->preListChanged();
    this->list.clear();
    this->m_canvas.clear();
    emit this->postListChanged();
}

QVariant PagesModel::getPage(int index)
{
    QVariantList::iterator it = this->m_canvas.begin();
    return *(it + index);
}

bool PagesModel::linkPage(QVariant canvas)
{
    QQmlEngine::setObjectOwnership(qvariant_cast<QObject *>(canvas), QQmlEngine::CppOwnership);
    this->m_canvas.push_back(QVariant(canvas));

    return true;
}

int PagesModel::count()
{
    return this->list.size();
}
