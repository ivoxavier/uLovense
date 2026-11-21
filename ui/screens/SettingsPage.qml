
import QtQuick 2.7
import Lomiri.Components 1.3

Page {
    id: settingsPage

    header: PageHeader {
        title: i18n.tr("Settings")
    }

    Rectangle {
        anchors.fill: parent
        color: "#101018"
    }

    Flickable {
        anchors.fill: parent
        contentHeight: settingsColumn.height + units.gu(6)
        clip: true

        Column {
            id: settingsColumn

            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
                margins: units.gu(3)
            }

            spacing: units.gu(3)

            Label {
                text: i18n.tr("General")
                color: "#FFFFFF"
                font.pixelSize: units.gu(2.5)
                font.bold: true
            }

            Rectangle {
                width: parent.width
                height: units.gu(8)
                radius: units.gu(2)
                color: "#1D1D2B"
                border.color: "#343044"

                Label {
                    anchors {
                        left: parent.left
                        leftMargin: units.gu(2)
                        verticalCenter: parent.verticalCenter
                    }

                    text: i18n.tr("Auto connect")
                    color: "#FFFFFF"
                    font.pixelSize: units.gu(2)
                }

                Switch {
                    id: autoConnect

                    anchors {
                        right: parent.right
                        rightMargin: units.gu(2)
                        verticalCenter: parent.verticalCenter
                    }
                }
            }

            Rectangle {
                width: parent.width
                height: units.gu(0.1)
                color: "#343044"
            }

            Label {
                text: i18n.tr("Device preferences")
                color: "#FFFFFF"
                font.pixelSize: units.gu(2.5)
                font.bold: true
            }

            Rectangle {
                width: parent.width
                height: units.gu(17)
                radius: units.gu(2)
                color: "#1D1D2B"
                border.color: "#343044"

                Column {
                    anchors {
                        fill: parent
                        margins: units.gu(2)
                    }

                    spacing: units.gu(2)

                    Label {
                        text: i18n.tr("Default intensity")
                        color: "#FFFFFF"
                        font.pixelSize: units.gu(2)
                    }

                    Slider {
                        id: intensitySlider

                        width: parent.width
                        minimumValue: 0
                        maximumValue: 20
                        value: 10
                    }

                    Label {
                        text: i18n.tr("Intensity: ") +
                              Math.round(intensitySlider.value) + " / 20"
                        color: "#C879FF"
                    }
                }
            }

            Rectangle {
                width: parent.width
                height: units.gu(17)
                radius: units.gu(2)
                color: "#1D1D2B"
                border.color: "#343044"

                Column {
                    anchors {
                        fill: parent
                        margins: units.gu(2)
                    }

                    spacing: units.gu(2)

                    Label {
                        text: i18n.tr("Default duration")
                        color: "#FFFFFF"
                        font.pixelSize: units.gu(2)
                    }

                    Slider {
                        id: durationSlider

                        width: parent.width
                        minimumValue: 1
                        maximumValue: 60
                        value: 10
                    }

                    Label {
                        text: Math.round(durationSlider.value) +
                              i18n.tr(" minutes")
                        color: "#C879FF"
                    }
                }
            }

            Rectangle {
                width: parent.width
                height: units.gu(0.1)
                color: "#343044"
            }

            Label {
                text: i18n.tr("Application")
                color: "#FFFFFF"
                font.pixelSize: units.gu(2.5)
                font.bold: true
            }

            Label {
                text: "uLovense 1.0.0"
                color: "#9999AA"
                font.pixelSize: units.gu(1.8)
            }

            Label {
                text: i18n.tr("Developed by Ivo Xavier")
                color: "#666677"
                font.pixelSize: units.gu(1.5)
            }
        }
    }
}
