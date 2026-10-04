import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Notifications

import "config.js" as Config

Scope {
    id: root

    function isOsd(n) {
        return n.appName === "changevolume" || n.appName === "changebrightness"
    }

    NotificationServer {
        id: server
        actionsSupported: true
        bodySupported: true
        imageSupported: true
        keepOnReload: true

        onNotification: n => {
            n.tracked = true
        }
    }

    // Split tracked notifications into normal vs OSD
    ScriptModel {
        id: normalModel
        values: server.trackedNotifications.values.filter(n => !root.isOsd(n))
    }
    ScriptModel {
        id: osdModel
        values: server.trackedNotifications.values.filter(n => root.isOsd(n))
    }

    // ───────────── Normal notifications: top right ─────────────
    PanelWindow {
        anchors { top: true; right: true }
        margins { top: 12; right: 12 }

        implicitWidth: Config.notifications.width
        implicitHeight: Math.max(1, column.implicitHeight)
        color: "transparent"

        exclusionMode: ExclusionMode.Ignore
        WlrLayershell.layer: WlrLayer.Overlay
        WlrLayershell.namespace: "quickshell-notifications"

        visible: normalModel.values.length > 0

        ColumnLayout {
            id: column
            width: parent.width
            spacing: Config.notifications.spacing

            Repeater {
                model: normalModel

                delegate: Rectangle {
                    id: card
                    required property var modelData

                    Layout.fillWidth: true
                    implicitHeight: content.implicitHeight + 24
                    radius: 10
                    color: Config.colors.bg
                    border.width: 1
                    border.color: modelData.urgency === NotificationUrgency.Critical
                                  ? Config.colors.red : Config.colors.muted

                    Timer {
                        interval: card.modelData.expireTimeout > 0
                                  ? card.modelData.expireTimeout * 1000
                                  : Config.notifications.timeout
                        running: card.modelData.urgency !== NotificationUrgency.Critical
                        onTriggered: card.modelData.expire()
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: card.modelData.dismiss()
                    }

                    RowLayout {
                        id: content
                        anchors { fill: parent; margins: 12 }
                        spacing: 10

                        Image {
                            visible: card.modelData.image !== ""
                            source: card.modelData.image
                            Layout.preferredWidth: 40
                            Layout.preferredHeight: 40
                            fillMode: Image.PreserveAspectFit
                        }

                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 2

                            Text {
                                text: card.modelData.appName
                                color: Config.colors.muted
                                font.pixelSize: 11
                            }
                            Text {
                                text: card.modelData.summary
                                color: Config.colors.cyan
                                font.pixelSize: 14
                                font.bold: true
                                Layout.fillWidth: true
                                elide: Text.ElideRight
                            }
                            Text {
                                visible: text !== ""
                                text: card.modelData.body
                                color: Config.colors.fg
                                font.pixelSize: 12
                                Layout.fillWidth: true
                                wrapMode: Text.Wrap
                                maximumLineCount: 4
                                elide: Text.ElideRight
                                textFormat: Text.StyledText
                            }

                            RowLayout {
                                visible: card.modelData.actions.length > 0
                                spacing: 6
                                Repeater {
                                    model: card.modelData.actions
                                    delegate: Rectangle {
                                        required property var modelData
                                        radius: 6
                                        color: Config.colors.bgDark
                                        implicitWidth: label.implicitWidth + 16
                                        implicitHeight: label.implicitHeight + 8
                                        Text {
                                            id: label
                                            anchors.centerIn: parent
                                            text: parent.modelData.text
                                            color: Config.colors.blue
                                            font.pixelSize: 11
                                        }
                                        MouseArea {
                                            anchors.fill: parent
                                            onClicked: parent.modelData.invoke()
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    // ───────────── OSD (volume/brightness): bottom center ─────────────
    PanelWindow {
        // Anchoring to only one edge centers the window on the other axis
        anchors { bottom: true }
        margins { bottom: 80 }

        implicitWidth: Config.notifications.osdWidth
        implicitHeight: Math.max(1, osdColumn.implicitHeight)
        color: "transparent"

        exclusionMode: ExclusionMode.Ignore
        WlrLayershell.layer: WlrLayer.Overlay
        WlrLayershell.namespace: "quickshell-osd"

        visible: osdModel.values.length > 0

        ColumnLayout {
            id: osdColumn
            width: parent.width
            spacing: Config.notifications.spacing

            Repeater {
                model: osdModel

                delegate: Rectangle {
                    id: osd
                    required property var modelData

                    readonly property int value: parseInt(modelData.body) || 0
                    readonly property bool muted: modelData.summary.indexOf("Muted") >= 0
                    readonly property bool isBrightness: modelData.appName === "changebrightness"

                    // Nerd Font (Material Design) glyphs as surrogate pairs
                    readonly property string glyph: {
                        if (isBrightness) return "\uDB80\uDCE0"        // brightness
                        if (muted || value === 0) return "\uDB81\uDF5F" // volume mute
                        if (value < 34) return "\uDB81\uDD7F"          // volume low
                        if (value < 67) return "\uDB81\uDD80"          // volume medium
                        return "\uDB81\uDD7E"                          // volume high
                    }

                    Layout.fillWidth: true
                    implicitHeight: osdContent.implicitHeight + 24
                    radius: 12
                    color: Config.colors.bg
                    border.width: 1
                    border.color: Config.colors.muted

                    Timer {
                        id: osdTimer
                        interval: Config.notifications.osdTimeout
                        running: true
                        onTriggered: osd.modelData.expire()
                    }

                    // Restart the countdown when the same notification is updated in place
                    Connections {
                        target: osd.modelData
                        function onBodyChanged()    { osdTimer.restart() }
                        function onSummaryChanged() { osdTimer.restart() }
                    }

                    RowLayout {
                        id: osdContent
                        anchors { fill: parent; margins: 12 }
                        spacing: 12

                        Text {
                            text: osd.glyph
                            color: osd.muted ? Config.colors.muted : Config.colors.cyan
                            font.family: "Symbols Nerd Font"
                            font.pixelSize: 26
                            Layout.preferredWidth: 32
                            horizontalAlignment: Text.AlignHCenter
                        }

                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 6

                            Text {
                                text: osd.modelData.summary
                                color: Config.colors.fg
                                font.pixelSize: 13
                                font.bold: true
                            }

                            Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 6
                                radius: 3
                                color: Config.colors.bgDark

                                Rectangle {
                                    width: parent.width * Math.min(osd.value, 100) / 100
                                    height: parent.height
                                    radius: 3
                                    color: osd.muted ? Config.colors.muted : Config.colors.cyan
                                    Behavior on width { NumberAnimation { duration: 120 } }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}