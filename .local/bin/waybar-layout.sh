#!/bin/sh

# Toggler layout Waybar.
# flat     -> config.jsonc + style.css (tema colore attivo)
# islands  -> config.islands.jsonc  + themes/islands.css   (3 isole flottanti)
# vertical -> config.vertical.jsonc + themes/vertical.css  (barra a sinistra)
# dock     -> config.dock.jsonc     + themes/dock.css      (isola in basso)

CHOICE=$(printf 'flat\nislands\nvertical\ndock\nbottom\nfloating\nsplit' | rofi -dmenu -i -p ' Waybar layout')
[ -z "$CHOICE" ] && exit 0

# -x = match esatto sul nome processo: uccide solo "waybar", NON questo
# script (il cui comm e' "waybar-layout.s", che altrimenti verrebbe colpito
# da "pkill waybar", facendolo morire prima del rilancio -> barra sparita).
pkill -x waybar 2>/dev/null
sleep 0.3

W="$HOME/.config/waybar"
case "$CHOICE" in
    islands)  setsid -f waybar -c "$W/config.islands.jsonc"  -s "$W/themes/islands.css"  >/dev/null 2>&1 ;;
    vertical) setsid -f waybar -c "$W/config.vertical.jsonc" -s "$W/themes/vertical.css" >/dev/null 2>&1 ;;
    dock)     setsid -f waybar -c "$W/config.dock.jsonc"     -s "$W/themes/dock.css"     >/dev/null 2>&1 ;;
    bottom)   setsid -f waybar -c "$W/config.bottom.jsonc"   -s "$W/themes/bottom.css"   >/dev/null 2>&1 ;;
    floating) setsid -f waybar -c "$W/config.floating.jsonc" -s "$W/themes/floating.css" >/dev/null 2>&1 ;;
    split)    setsid -f waybar -c "$W/config.split.jsonc"    -s "$W/themes/split.css"    >/dev/null 2>&1 ;;
    flat)     setsid -f waybar >/dev/null 2>&1 ;;
esac
