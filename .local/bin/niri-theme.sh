#!/bin/sh
# Switcher tema "di sistema" Niri: applica in un colpo niri + wallpaper + mako + swayosd.
# (rofi e waybar restano switcher indipendenti: Mod+Alt+R / Mod+Alt+B)

THEME=$(printf 'original\ncyberdeck\naero\nink\neverforest\nrosepine\noxocarbon\nsynthwave\ndeathstranding\ndune\nmatrix\nwin95' \
    | rofi -dmenu -i -p 'Niri theme')
[ -z "$THEME" ] && exit 0

# 1) Tema Niri (live-reload automatico al salvataggio del config)
sed -i -E 's|^include "themes/.*\.kdl"|include "themes/'"$THEME"'.kdl"|' \
    "$HOME/.config/niri/config.kdl"

# 2) Wallpaper del tema (ferma lo slideshow casuale per non farlo sovrascrivere)
set -- "$HOME/Immagini/Sfondi/temi/$THEME".*
WP="$1"
if [ -f "$WP" ]; then
    pkill -f awww_slideshow.sh 2>/dev/null
    awww img "$WP" --transition-type random --transition-step 90 --transition-fps 120 2>/dev/null
fi

# 3) mako (notifiche)
MK="$HOME/.config/mako/themes/$THEME.conf"
[ -f "$MK" ] && cp "$MK" "$HOME/.config/mako/config" && makoctl reload 2>/dev/null

# 4) swayosd (OSD volume/luminosita': serve un restart per applicare lo stile)
SO="$HOME/.config/swayosd/themes/$THEME.css"
if [ -f "$SO" ]; then
    cp "$SO" "$HOME/.config/swayosd/style.css"
    pkill swayosd-server 2>/dev/null
    setsid -f swayosd-server >/dev/null 2>&1
fi
