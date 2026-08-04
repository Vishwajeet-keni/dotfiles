#!/bin/bash
DOTFILES="$HOME/dotfiles"

mkdir -p "$HOME/.config"

ln -sf "$DOTFILES/.config/nvim" "$HOME/.config/nvim"
ln -sf "$DOTFILES/.config/hypr" "$HOME/.config/hypr"
ln -sf "$DOTFILES/.config/eww" "$HOME/.config/eww"
ln -sf "$DOTFILES/.config/scripts" "$HOME/.config/scripts"
ln -sf "$DOTFILES/.config/gtk-3.0" "$HOME/.config/gtk-3.0"
ln -sf "$DOTFILES/.config/gtk-4.0" "$HOME/.config/gtk-4.0"
ln -sf "$DOTFILES/.config/kitty" "$HOME/.config/kitty"
ln -sf "$DOTFILES/.config/rofi" "$HOME/.config/rofi"
ln -sf "$DOTFILES/wallpapers" "$HOME/wallpapers"