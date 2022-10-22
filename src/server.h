#pragma once
#include <QObject>

#if (defined Q_OS_LINUX || defined Q_OS_FREEBSD) && !defined Q_OS_ANDROID
class OrgKdeQuillActionsInterface;

namespace AppInstance
{
QVector<QPair<QSharedPointer<OrgKdeQuillActionsInterface>, QStringList>> appInstances(const QString& preferredService);
bool attachToExistingInstance();

bool registerService();
}
#endif

class Server : public QObject
{
    Q_OBJECT
    Q_CLASSINFO("D-Bus Interface", "org.kde.quill.Actions")

    bool registerService();
public:
    explicit Server(QObject *parent = nullptr);
    void setQmlObject(QObject  *object);

public slots:
    void activateWindow();

    void quit();

private:
    QObject* m_qmlObject = nullptr;

signals:

};

