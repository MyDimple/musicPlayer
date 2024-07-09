#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "search.h"
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QCoreApplication::setOrganizationName("MyOrganization");
    QCoreApplication::setOrganizationDomain("myorganization.com");
    QCoreApplication::setApplicationName("FreeMsp");

    QQmlApplicationEngine engine;

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
