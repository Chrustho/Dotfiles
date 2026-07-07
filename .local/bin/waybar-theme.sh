#!/bin/sh

# Switcher tema waybar

T=$(printf 'gruvbox\ngruvmaterial\nchevron\nbio\ndeathstranding\ndune\nmatrix\nwin95\nbauhaus\nconcrete\neditorial\nmocha\npoimandres\neldritch\nneochor\nperiwinkle\ndechor\nmellow\nmystbloom\noh-lucy\npetrichor\nglass\nneon\ncatppuccin\nnord\ntokyonight\nrosepine-power' | rofi -dmenu -i -p ' Waybar theme')
[ -z "$T" ] && exit 0

SRC="$HOME/.config/waybar/themes/$T.css"
# -x: match esatto, cosi' SIGUSR2 va solo a waybar e non a questo script.
[ -f "$SRC" ] && cp "$SRC" "$HOME/.config/waybar/style.css" && pkill -x -SIGUSR2 waybar
