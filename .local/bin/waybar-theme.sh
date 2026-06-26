#!/bin/sh

# Switcher tema waybar

T=$(printf 'gruvbox\ndeathstranding\ndune\nmatrix\nwin95\nbauhaus\nconcrete\neditorial\nmocha\npoimandres\neldritch' | rofi -dmenu -i -p ' Waybar theme')
[ -z "$T" ] && exit 0

SRC="$HOME/.config/waybar/themes/$T.css"
[ -f "$SRC" ] && cp "$SRC" "$HOME/.config/waybar/style.css" && pkill -SIGUSR2 waybar
