#!/bin/sh
# Switcher temi Waybar: copia themes/<nome>.css su style.css e ricarica lo stile.
# L'ordine dei widget (config.jsonc) resta invariato: cambia solo il CSS.

T=$(printf 'gruvbox\ndeathstranding\ndune\nmatrix\nwin95' | rofi -dmenu -i -p ' Waybar theme')
[ -z "$T" ] && exit 0

SRC="$HOME/.config/waybar/themes/$T.css"
[ -f "$SRC" ] && cp "$SRC" "$HOME/.config/waybar/style.css" && pkill -SIGUSR2 waybar
