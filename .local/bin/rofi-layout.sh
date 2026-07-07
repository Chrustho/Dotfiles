#!/bin/sh

# Switcher forma/layout di rofi (config.rasi).
# Le palette (colors.rasi, Mod+Alt+R) restano invariate: ogni layout le importa.

L=$(printf 'rounded\nfloat\ngrid\nspotlight\nclassic' \
    | rofi -dmenu -i -p ' Rofi layout')
[ -z "$L" ] && exit 0

SRC="$HOME/.config/rofi/layouts/$L.rasi"
[ -f "$SRC" ] && cp "$SRC" "$HOME/.config/rofi/config.rasi"
