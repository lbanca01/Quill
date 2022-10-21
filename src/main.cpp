#include <QCommandLineParser>
#include <QDate>
#include <QDir>
#include <QIcon>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include <KI18n/KLocalizedString>

#include <MauiKit/Core/mauiapp.h>

#ifdef Q_OS_ANDROID
#include <MauiKit/Core/mauiandroid.h>
#include <QGuiApplication>
#else
#include <QApplication>
#endif

#include "../quill_version.h"

#define QUILL_URI "org.maui.quill"

int Q_DECL_EXPORT main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QCoreApplication::setAttribute(Qt::AA_UseHighDpiPixmaps, true);

#ifdef Q_OS_ANDROID
    QGuiApplication app(argc, argv);
    if (!MAUIAndroid::checkRunTimePermissions({"android.permission.WRITE_EXTERNAL_STORAGE"}))
        return -1;
#else
    QApplication app(argc, argv);
#endif

    app.setOrganizationName(QStringLiteral("IDK"));
    //  app.setWindowIcon(QIcon(":/quill.png"));

    MauiApp::instance()->setIconName("qrc:/quill.svg");

    KLocalizedString::setApplicationDomain("quill");
    KAboutData about(QStringLiteral("quill"),
                     i18n("Quill"),
                     QUILL_VERSION_STRING,
                     i18n("TODO"),
                     KAboutLicense::LGPL_V3,
                     i18n("© 2019-%1 Bored random guy", QString::number(QDate::currentDate().year())),
                     QStringLiteral("tbd"));
    about.addAuthor(i18n("Sbancuz"), i18n("Developer"), QStringLiteral("tbd.com"));
    about.setHomepage("https://mauikit.org");
    about.setProductName("maui/quill");
    //    about.setBugAddress("https://invent.kde.org/maui/buho/-/issues");
    about.setOrganizationDomain(QUILL_URI);
    about.setProgramLogo(app.windowIcon());

    KAboutData::setApplicationData(about);

    // QCommandLineOption newNoteContent(QStringList() << "c" << "content", "new note contents.", "content");

    QCommandLineParser parser;

    // parser.addOption(newNoteOption);
    // parser.addOption(newNoteContent);

    about.setupCommandLine(&parser);
    parser.process(app);

    about.processCommandLine(&parser);

#if (defined Q_OS_LINUX || defined Q_OS_FREEBSD) && !defined Q_OS_ANDROID

    // if(newNote)
    // {
    //     if(parser.isSet(newNoteContent))
    //     {
    //         noteContent = parser.value(newNoteContent);
    //     }
    // }
    //
    // if (AppInstance::attachToExistingInstance(newNote, noteContent))
    // {
    //     // Successfully attached to existing instance of Nota
    //     return 0;
    // }
    //
    AppInstance::registerService();
#endif

    // auto server = std::make_unique<Quill>();

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);

    engine.rootContext()->setContextObject(new KLocalizedContext(&engine));
    engine.load(url);
    return app.exec();
}
