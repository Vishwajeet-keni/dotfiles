#!/bin/bash

WALLPAPER_DIR="$HOME/wallpapers/static"

# Select wallpaper
if [ -n "$1" ]; then
    WALLPAPER="$1"
else
    WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | shuf -n 1)
fi

if [ -z "$WALLPAPER" ] || [ ! -f "$WALLPAPER" ]; then
    echo "Error: No valid wallpaper found in $WALLPAPER_DIR"
    exit 1
fi

WALLPAPER=$(realpath "$WALLPAPER")

# 1. Update Hyprlock Wallpaper Link
mkdir -p ~/.cache
ln -sf "$WALLPAPER" ~/.cache/current_wallpaper

# 2. Update Desktop Wallpaper via awww
awww img "$WALLPAPER" --transition-type wipe --transition-fps 60

# 3. Generate Colors with Pywal (export everywhere, omit terminal sequences with -n)
wal -i "$WALLPAPER" -q

# 4. Update Kitty Terminal globally across all open terminals
kitty @ set-colors -a -c ~/.cache/wal/colors-kitty.conf 2>/dev/null || true

# 5. Reload Hyprland to update borders from hyprland.lua
hyprctl reload