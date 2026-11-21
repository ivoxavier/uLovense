
import QtQuick 2.7
import Lomiri.Components 1.3

Page {
    id: devicePage

    header: PageHeader {
        title: i18n.tr("My Device")
    }

    property bool connected: false
    property int batteryLevel: 0
    property string scanStatus: i18n.tr("Bluetooth not scanned")

    ListModel {
        id: devicesModel
    }

    Connections {
        target: bluetoothManager

        onScanningChanged: {
            if (bluetoothManager.scanning) {
                devicePage.scanStatus = i18n.tr("Searching for BLE devices...")
                console.log("[uLovense][QML] BLE scan started")
            }
        }

        onDeviceFound: {
            console.log("[uLovense][QML] Device:", name, address, lowEnergy)

            var exists = false

            for (var i = 0; i < devicesModel.count; i++) {
                if (devicesModel.get(i).address === address) {
                    exists = true
                    break
                }
            }

            if (!exists) {
                devicesModel.append({
                    "name": name.length > 0 ? name : "Unknown device",
                    "address": address,
                    "lowEnergy": lowEnergy
                })
            }
        }

        onScanFinished: {
            devicePage.scanStatus = i18n.tr("Search completed")
            console.log("[uLovense][QML] BLE scan completed")
        }

        onScanError: {
            devicePage.scanStatus = i18n.tr("Bluetooth error: ") + message
            console.warn("[uLovense][QML] BLE error:", message)
        }
    }

    Component.onCompleted: {
        console.log("[uLovense][QML] DevicePage loaded")
    }

    Rectangle {
        anchors.fill: parent
        color: "#101018"
    }

    Flickable {
        anchors.fill: parent
        contentHeight: deviceColumn.height + units.gu(6)
        clip: true

        Column {
            id: deviceColumn

            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
                margins: units.gu(3)
            }

            spacing: units.gu(3)

            Label {
                text: i18n.tr("My Lovense Device")
                color: "#FFFFFF"
                font.pixelSize: units.gu(3)
                font.bold: true
            }

            Rectangle {
                width: parent.width
                height: units.gu(22)
                radius: units.gu(2)
                color: "#1D1D2B"
                border.color: "#343044"

                Column {
                    anchors.centerIn: parent
                    spacing: units.gu(1)

                    Label {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "♡"
                        color: "#C879FF"
                        font.pixelSize: units.gu(8)
                    }

                    Label {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "Lovense Lush"
                        color: "#FFFFFF"
                        font.pixelSize: units.gu(2.5)
                        font.bold: true
                    }

                    Label {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: connected
                              ? i18n.tr("Connected")
                              : i18n.tr("Not connected")
                        color: connected ? "#55DD99" : "#FF6677"
                    }

                    Label {
                        anchors.horizontalCenter: parent.horizontalCenter
                        visible: connected
                        text: i18n.tr("Battery: ") + batteryLevel + "%"
                        color: "#AAAAAA"
                    }
                }
            }

            Label {
                text: i18n.tr("Bluetooth discovery")
                color: "#FFFFFF"
                font.bold: true
                font.pixelSize: units.gu(2.2)
            }

            Button {
                width: parent.width
                text: bluetoothManager.scanning
                      ? i18n.tr("Searching...")
                      : i18n.tr("Search for devices")
                color: "#963FE0"
                enabled: !bluetoothManager.scanning

                onClicked: {
                    devicesModel.clear()
                    devicePage.scanStatus = i18n.tr("Starting search...")
                    console.log("[uLovense][QML] Requesting BLE scan")
                    bluetoothManager.startScan()
                }
            }

            Button {
                width: parent.width
                text: i18n.tr("Stop search")
                color: "#383044"
                enabled: bluetoothManager.scanning

                onClicked: {
                    console.log("[uLovense][QML] Requesting scan stop")
                    bluetoothManager.stopScan()
                }
            }

            Label {
                width: parent.width
                wrapMode: Text.WordWrap
                text: scanStatus
                color: "#C879FF"
                font.pixelSize: units.gu(1.7)
            }

            Label {
                text: i18n.tr("Found devices: ") + devicesModel.count
                color: "#FFFFFF"
                font.bold: true
            }

            Repeater {
                model: devicesModel

                delegate: Rectangle {
                    width: deviceColumn.width
                    height: units.gu(11)
                    radius: units.gu(1)
                    color: "#1D1D2B"
                    border.color: "#343044"

                    Column {
                        anchors {
                            fill: parent
                            margins: units.gu(1.5)
                        }

                        spacing: units.gu(0.5)

                        Label {
                            width: parent.width
                            text: name
                            color: "#FFFFFF"
                            font.bold: true
                            elide: Text.ElideRight
                        }

                        Label {
                            width: parent.width
                            text: address
                            color: "#AAAAAA"
                            font.pixelSize: units.gu(1.5)
                        }

                        Label {
                            text: lowEnergy ? "Bluetooth LE" : "Bluetooth Classic"
                            color: lowEnergy ? "#55DD99" : "#FFBB66"
                            font.pixelSize: units.gu(1.5)
                        }
                    }
                }
            }

            Rectangle {
                width: parent.width
                height: units.gu(0.1)
                color: "#343044"
            }

            Label {
                text: i18n.tr("Vibration intensity")
                color: "#FFFFFF"
                font.bold: true
                font.pixelSize: units.gu(2.2)
            }

            Slider {
                id: vibrationSlider
                width: parent.width
                minimumValue: 0
                maximumValue: 20
                value: 0
                enabled: connected
            }

            Label {
                text: Math.round(vibrationSlider.value) + " / 20"
                color: "#C879FF"
                font.pixelSize: units.gu(2)
            }

            Button {
                width: parent.width
                text: i18n.tr("Stop")
                color: "#B83250"
                enabled: connected

                onClicked: {
                    vibrationSlider.value = 0
                    console.log("[uLovense][QML] Stop clicked")
                }
            }

            Label {
                width: parent.width
                wrapMode: Text.WordWrap
                text: i18n.tr("Device controls will become available after connecting to your Lovense device.")
                color: "#888899"
                font.pixelSize: units.gu(1.5)
            }
        }
    }
}
