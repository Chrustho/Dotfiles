#!/bin/sh
# Switcher palette rofi: copia themes/<nome>.rasi su colors.rasi.
# Rofi rilegge il tema a ogni avvio, quindi il prossimo menu usa la nuova palette.

THEME=$(printf 'original\ncyberdeck\naero\nink\neverforest\nrosepine\noxocarbon\nsynthwave\ndeathstranding\ndune\nmatrix\nwin95\nbauhaus\nconcrete\neditorial\nmocha\npoimandres\neldritch' \
    | rofi -dmenu -i -p ' Rofi theme')
[ -z "$THEME" ] && exit 0

SRC="$HOME/.config/rofi/themes/$THEME.rasi"
[ -f "$SRC" ] && cp "$SRC" "$HOME/.config/rofi/colors.rasi"
