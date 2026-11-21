#include <QGuiApplication>
#include <QCoreApplication>
#include <QUrl>
#include <QString>
#include <QQuickView>
#include <QQmlContext>
#include <QDebug>
#include "repository/services/BluetoothManager.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    app.setApplicationName("ulovense.ivoxavier");

    qInfo() << "[uLovense] A iniciar aplicação";

    BluetoothManager bluetoothManager;

    QQuickView view;

    view.rootContext()->setContextProperty(
        "bluetoothManager",
        &bluetoothManager
        );

    view.setSource(QUrl("qrc:/Main.qml"));
    view.setResizeMode(QQuickView::SizeRootObjectToView);
    view.show();

    qInfo() << "[uLovense] Interface carregada";

    return app.exec();
}
