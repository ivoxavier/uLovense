
import QtQuick 2.7
import Lomiri.Components 1.3
import QtQuick.Layouts 1.3

Page {
    id: menuScreen

    header: PageHeader {
        title: i18n.tr("uLovense")
    }

    Rectangle {
        anchors.fill: parent
        color: "#101018"
    }

    ColumnLayout {
        anchors {
            fill: parent
            margins: units.gu(3)
        }

        spacing: units.gu(2)

        Label {
            text: i18n.tr("Welcome back")
            color: "#FFFFFF"
            font.pixelSize: units.gu(4)
            font.bold: true
            Layout.fillWidth: true
        }

        Label {
            text: i18n.tr("Your Lovense devices")
            color: "#9999AA"
            font.pixelSize: units.gu(2)
            Layout.fillWidth: true
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: units.gu(22)

            radius: units.gu(2)
            color: "#1D1D2B"
            border.color: "#343044"

            Column {
                anchors.centerIn: parent
                spacing: units.gu(2)

                Label {
                    text: "♡"
                    color: "#C879FF"
                    font.pixelSize: units.gu(7)
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Label {
                    text: i18n.tr("No device connected")
                    color: "#FFFFFF"
                    font.pixelSize: units.gu(2.2)
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Label {
                    text: i18n.tr("Connect your Lovense device to begin")
                    color: "#9999AA"
                    font.pixelSize: units.gu(1.5)
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }

        Button {
            text: i18n.tr("Connect device")
            Layout.fillWidth: true
            color: "#963FE0"

            onClicked: {
                pageStack.push(Qt.resolvedUrl("DevicePage.qml"))
            }
        }

        Button {
            text: i18n.tr("Device settings")
            Layout.fillWidth: true
            color: "#292638"

            onClicked: {
                pageStack.push(Qt.resolvedUrl("SettingsPage.qml"))
            }
        }

        Item {
            Layout.fillHeight: true
        }

        Label {
            text: "uLovense • 1.0.0"
            color: "#666677"
            font.pixelSize: units.gu(1.4)
            Layout.alignment: Qt.AlignHCenter
        }
    }
}
