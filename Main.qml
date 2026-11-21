
/*
 * Copyright (C) 2026 Ivo Xavier
 * SPDX-License-Identifier: GPL-3.0-only
 */

import QtQuick 2.7
import Lomiri.Components 1.3

MainView {
    id: root

    property alias appPageStack: pageStack

    objectName: "mainView"
    applicationName: "ulovense.ivoxavier"

    width: units.gu(45)
    height: units.gu(75)

    backgroundColor: "#101018"

    PageStack {
        id: pageStack
        anchors.fill: parent
    }

    Item {
        id: splashScreen

        anchors.fill: parent
        z: 100

        Rectangle {
            anchors.fill: parent
            color: "#101018"
        }

        Column {
            anchors.centerIn: parent
            spacing: units.gu(3)

            Image {
                id: logo

                source: "qrc:/assets/logo.svg"

                width: units.gu(20)
                height: units.gu(20)

                fillMode: Image.PreserveAspectFit
                smooth: true

                opacity: 0
                scale: 0.65

                SequentialAnimation {
                    running: true

                    ParallelAnimation {
                        NumberAnimation {
                            target: logo
                            property: "opacity"
                            from: 0
                            to: 1
                            duration: 900
                            easing.type: Easing.OutCubic
                        }

                        NumberAnimation {
                            target: logo
                            property: "scale"
                            from: 0.65
                            to: 1
                            duration: 900
                            easing.type: Easing.OutBack
                        }
                    }
                }
            }

            Label {
                id: appName

                text: "uLovense"
                color: "#FFFFFF"

                font.pixelSize: units.gu(4)
                font.bold: true

                anchors.horizontalCenter: parent.horizontalCenter

                opacity: 0

                SequentialAnimation {
                    running: true

                    PauseAnimation {
                        duration: 350
                    }

                    NumberAnimation {
                        target: appName
                        property: "opacity"
                        from: 0
                        to: 1
                        duration: 800
                    }
                }
            }

            Label {
                text: "YOUR DEVICE. YOUR CONTROL."
                color: "#888899"

                font.pixelSize: units.gu(1.4)
                font.letterSpacing: units.gu(0.25)

                anchors.horizontalCenter: parent.horizontalCenter

                opacity: 0.8
            }
        }

        // Loading indicator
        Rectangle {
            id: loadingBackground

            width: units.gu(12)
            height: units.gu(0.4)

            radius: height / 2
            color: "#30303D"

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: units.gu(12)

            Rectangle {
                id: loadingBar

                width: 0
                height: parent.height
                radius: parent.radius

                color: "#B85CFF"

                NumberAnimation {
                    target: loadingBar
                    property: "width"
                    from: 0
                    to: loadingBackground.width
                    duration: 1900
                    running: true
                    easing.type: Easing.InOutCubic
                }
            }
        }

        Timer {
            interval: 2100
            running: true
            repeat: false

            onTriggered: {
                pageStack.push(Qt.resolvedUrl("qrc:/MenuPage.qml"))
                splashFade.start()
            }
        }

        NumberAnimation {
            id: splashFade

            target: splashScreen
            property: "opacity"

            from: 1
            to: 0

            duration: 450

            onStopped: {
                splashScreen.visible = false
            }
        }
    }
}
