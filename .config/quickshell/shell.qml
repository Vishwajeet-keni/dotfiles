import Quickshell
import "hypr_bar_qml/modules"

// Entry point. hypr_bar_qml/ is a subfolder here, not the shell root
// itself, so it's imported by relative path.
ShellRoot {
    HyprBar {}
}