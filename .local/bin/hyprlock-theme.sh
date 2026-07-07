#!/bin/sh

# Switcher stile hyprlock (lock screen).
# Copia lo stile scelto su ~/.config/hypr/hyprlock.conf.
# hyprlock legge la config all'avvio: il nuovo stile appare al prossimo blocco.

T=$(printf 'minimal\ncatppuccin\ntokyonight\ncyberpunk\nnord\nrosepine\nwin95' \
    | rofi -dmenu -i -p '  Hyprlock style')
[ -z "$T" ] && exit 0

SRC="$HOME/.config/hypr/hyprlock-themes/$T.conf"
[ -f "$SRC" ] || exit 1
cp "$SRC" "$HOME/.config/hypr/hyprlock.conf"

notify-send "Hyprlock" "Stile impostato: $T (attivo al prossimo blocco)" 2>/dev/null
