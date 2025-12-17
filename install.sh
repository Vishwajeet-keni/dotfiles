#!/bin/bash
DOTFILES="$HOME/dotfiles"

ln -sf "$DOTFILES/.config/nvim" "$HOME/.config/nvim"
ln -sf "$DOTFILES/.config/hypr" "$HOME/.config/hypr"
ln -sf "$DOTFILES/.config/eww" "$HOME/.config/eww"
ln -sf "$DOTFILES/.config/scripts" "$HOME/.config/scripts"   
ln -sf "$DOTFILES/wallpapers" "$HOME/wallpapers"
