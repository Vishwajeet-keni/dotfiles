import Quickshell
import Quickshell.Io
import QtQuick

// Quickshell port of the hypr_bar eww config.
// Place this whole folder at ~/.config/quickshell (or run it with
// `quickshell -p /path/to/this/folder`). See README.md for setup notes.
ShellRoot {
    id: root

    property var pal: Colors {}
    property var state: AppState {}

    // ── Battery stream (replaces deflisten battery-data + battery.sh's
    //    eww-specific low-battery-warning logic, which now lives here) ──
    StreamJsonListener {
        id: batteryStream
        command: "$HOME/.config/quickshell/scripts/battery.sh"
    }

    Connections {
        target: batteryStream
        function onDataChanged() {
            root.state.batteryData = batteryStream.data
            const d = batteryStream.data
            const level = parseInt(d.level, 10)
            const critical = d.status === "Discharging" && !isNaN(level) && level <= 30
            if (critical && !root.state.lowBattShown) {
                root.state.lowBattVisible = true
                root.state.lowBattShown = true
            } else if (!critical) {
                root.state.lowBattShown = false
            }
        }
    }

    Bar {
        id: bar
        pal: root.pal
        state: root.state
    }

    ControlCenter {
        pal: root.pal
        state: root.state
        anchor.window: bar
        anchor.rect.x: bar.width - implicitWidth - 8
        anchor.rect.y: bar.height + 4
    }

    CalendarPopup {
        pal: root.pal
        state: root.state
        anchor.window: bar
        anchor.rect.x: bar.width - implicitWidth - 8
        anchor.rect.y: bar.height + 4
    }

    LowBattWarning {
        pal: root.pal
        state: root.state
    }
}
