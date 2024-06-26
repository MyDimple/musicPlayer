#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "search.h"
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    // 设置组织名称和组织域
    QCoreApplication::setOrganizationName("MyOrganization");
    QCoreApplication::setOrganizationDomain("myorganization.com");
    QCoreApplication::setApplicationName("MyApp");

    QQmlApplicationEngine engine;

    // const QUrl url(QStringLiteral("qrc:/freems/Main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    // engine.load(url);
    engine.loadFromModule("se.qt.music", "Main");
    return app.exec();
}
