#include <QGuiApplication>
#include <QQmlContext>
#include <QQmlApplicationEngine>
#include <QCursor>
#include "mouse.h"
#include <QDebug>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
	Mouse mouse;
	engine.rootContext()->setContextProperty("myMouse", &mouse);
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
