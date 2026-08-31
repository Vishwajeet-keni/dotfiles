# hypr_bar → Quickshell

A Quickshell (QML) port of the [hypr_bar](https://github.com/Vishwajeet-keni/hypr_bar) eww
config: the top bar (Arch logo, workspaces, CPU/mem/temp, updates/wifi/battery menu,
clock), the calendar popup, the macOS-style control center, and the low-battery dialog.

## Install

1. Install [Quickshell](https://quickshell.org) and a Nerd Font (the original used
   JetBrainsMono Nerd Font — install it so the glyphs render correctly).
2. Copy this whole folder to `~/.config/quickshell/`:
   ```bash
   mkdir -p ~/.config/quickshell
   cp -r quickshell/* ~/.config/quickshell/
   chmod +x ~/.config/quickshell/scripts/*.sh
   ```
3. Launch it manually to test:
   ```bash
   quickshell
   ```
4. Once it looks right, autostart it from your Hyprland config:
   ```
   exec-once = quickshell
   ```

## What changed vs. the original eww config

- **Workspaces** now come from Quickshell's native Hyprland IPC
  (`Quickshell.Hyprland`) instead of `scripts/workspaces.sh` + `socat`. It's
  reactive out of the box, so that script (and its debounce/fallback-polling
  logic) is no longer needed — it isn't copied into `scripts/`.
- **`scripts/battery.sh`** was adapted: the `eww open low_batt_warning` call
  and its `/tmp` shown-flag are gone (that decision now lives in
  `shell.qml`, watching the stream), and the JSON now includes a `status`
  field (raw `Charging`/`Discharging`/`Full`) alongside `class`, since
  `class` gets overwritten to `"critical"` at low battery and would
  otherwise hide whether you're charging.
- **wifi.sh, bluetooth.sh, brightness.sh, volume.sh, power_mode.sh,
  system_stats.sh, updates.sh** are copied over unchanged — they already
  just print JSON and take an optional action argument, which is exactly
  what `JsonPoller.qml` expects.
- **SCSS → QML.** There's no stylesheet; colors/spacing live directly in
  the QML files. `Colors.qml` carries the same Catppuccin Mocha values as
  `scss/variables.scss`. (Named `Colors` rather than `Palette` because
  QtQuick already ships a built-in `Palette` type — a same-directory file
  sharing that name loses to the module-imported one.)
- **The GTK `calendar` widget** has no QML equivalent, so `CalendarPopup.qml`
  draws a simple month grid instead (today highlighted in mauve).
- **The low-battery dialog** is a `FloatingWindow` rather than an
  anchored panel, matching the original's `:windowtype "dialog"`. Add a
  Hyprland window rule if you want it forced to center (see the comment
  at the top of `LowBattWarning.qml`).

## File map (eww → Quickshell)

| eww file | Quickshell file |
|---|---|
| `hypr_bar.yuck` (`defwindow hypr_bar`) | `Bar.qml` + `shell.qml` |
| `widgets/bar/Arch_logo.yuck` | inline in `Bar.qml` |
| `widgets/bar/workspace.yuck` + `scripts/workspaces.sh` | `Workspaces.qml` (native Hyprland IPC) |
| `widgets/bar/system_stats.yuck` | `SystemStats.qml` + `StatItem.qml` |
| `widgets/bar/menu.yuck` | `MenuBar.qml` |
| `widgets/bar/updates.yuck` | folded into `MenuBar.qml` |
| `widgets/bar/wifi.yuck` | folded into `MenuBar.qml` |
| `widgets/bar/battery.yuck` (`battery` widget) | folded into `MenuBar.qml` |
| `widgets/bar/battery.yuck` (`low_batt_warning` widget) | `LowBattWarning.qml` |
| `widgets/bar/time_date_cal.yuck` | `TimeDate.qml` |
| `hypr_bar.yuck` (`defwindow cal_popup`) | `CalendarPopup.qml` |
| `widgets/control_center/control_center.yuck` | `ControlCenter.qml` |
| `widgets/control_center/tiles.yuck` | `ToggleTile.qml`, `IconTile.qml`, `GlassSlider.qml` |
| `style.scss` / `scss/*.scss` | `Colors.qml` + inline styling |
| n/a (new helper) | `JsonPoller.qml` (defpoll equivalent), `StreamJsonListener.qml` (deflisten equivalent), `AppState.qml` (shared UI state) |

## Known gaps / things to double check on your machine

- `system_stats.sh` reads `sensors coretemp-isa-0000` — adjust if your
  `lm_sensors` output uses a different chip name.
- `battery.sh` hardcodes `BAT0` — check `/sys/class/power_supply/` if your
  battery has a different name.
- Menu glyphs (wifi/bluetooth/power icons, the gear button, Stage/Mirror
  icons) are Nerd Font code points chosen to match the originals as
  closely as possible; swap any that don't render right for your font.
- I couldn't run this against an actual Quickshell/Hyprland install to
  verify pixel-for-pixel behavior, so treat this as a strong first draft —
  sanity-check `quickshell -p .` output and adjust spacing/colors to taste.
