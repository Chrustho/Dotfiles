#!/bin/sh

# Switcher palette rofi

THEME=$(printf 'original\ncyberdeck\naero\nink\neverforest\nbio\nrosepine\noxocarbon\nsynthwave\ngruvmaterial\ndeathstranding\ndune\nmatrix\nwin95\nbauhaus\nconcrete\neditorial\nmocha\npoimandres\neldritch\nneochor\nperiwinkle\ndechor\nmellow\nmystbloom\noh-lucy\npetrichor' \
    | rofi -dmenu -i -p ' Rofi theme')
[ -z "$THEME" ] && exit 0

SRC="$HOME/.config/rofi/themes/$THEME.rasi"
[ -f "$SRC" ] && cp "$SRC" "$HOME/.config/rofi/colors.rasi"
