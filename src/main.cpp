#include <QQmlApplicationEngine>

#include <QCommandLineParser>
#include <QFileInfo>
#include <QIcon>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>
#ifdef Q_OS_ANDROID
#include <QGuiApplication>
#include <QIcon>
#else
#include <QApplication>
#endif

#ifdef STATIC_KIRIGAMI
#include "./3rdparty/kirigami/src/kirigamiplugin.h"
#endif

#ifdef STATIC_MAUIKIT
#include "./mauikit/src/mauikit.h"
#include <QStyleHints>
#endif

#include "./models/pagesmodel.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

#ifdef Q_OS_ANDROID
    QGuiApplication app(argc, argv);
    //    QGuiApplication::styleHints()->setMousePressAndHoldInterval(2000); // in [ms]
#else
    QApplication app(argc, argv);
#endif

    app.setApplicationName("Kuill");
    app.setApplicationVersion("1.0.0");
    app.setApplicationDisplayName("Kuill");
    app.setWindowIcon(QIcon("./../assets/mauidemo.svg"));

    QQmlApplicationEngine engine;
#ifdef STATIC_KIRIGAMI
    KirigamiPlugin::getInstance().registerTypes();
#endif

#ifdef STATIC_MAUIKIT
    MauiKit::getInstance().registerTypes();

#endif

    // i don't know the purpose of the uri
    qmlRegisterType<PagesModel>("org.maui.kuill", 1, 0, "PagesList");


    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
