#!/bin/sh

# Switcher tema di sistema Niri

THEME=$(printf 'original\ncyberdeck\naero\nink\neverforest\nbio\nrosepine\noxocarbon\nsynthwave\ngruvmaterial\ndeathstranding\ndune\nmatrix\nwin95\nbauhaus\nconcrete\neditorial\nmocha\npoimandres\neldritch\nneochor\nperiwinkle\ndechor\nmellow\nmystbloom\noh-lucy\npetrichor' \
    | rofi -dmenu -i -p 'Niri theme')
[ -z "$THEME" ] && exit 0

sed -i -E 's|^include "themes/.*\.kdl"|include "themes/'"$THEME"'.kdl"|' \
    "$HOME/.config/niri/config.kdl"

case "$THEME" in
    concrete)   GAPS=12 ;;
    bio)        GAPS=34 ;;
    poimandres) GAPS=26 ;;
    eldritch)   GAPS=30 ;;
    mocha)      GAPS=36 ;;
    editorial)  GAPS=38 ;;
    bauhaus)    GAPS=42 ;;
    neochor|periwinkle|dechor|mellow|mystbloom|oh-lucy|petrichor) GAPS=20 ;;
    *)          GAPS=37.5 ;;
esac
sed -i -E 's|^( *)gaps [0-9.]+|\1gaps '"$GAPS"'|' \
    "$HOME/.config/niri/config.kdl"

if [ "$THEME" = "bio" ]; then
    # Tema organico: usa lo shader neowall invece di uno sfondo statico
    pkill -f awww_slideshow.sh 2>/dev/null
    "$HOME/.local/bin/cicla_shader.sh" set bio >/dev/null 2>&1
else
    set -- "$HOME/Immagini/Sfondi/temi/$THEME".*
    WP="$1"
    if [ -f "$WP" ]; then
        pkill -f awww_slideshow.sh 2>/dev/null
        awww img "$WP" --transition-type random --transition-step 90 --transition-fps 120 2>/dev/null
    fi
fi

MK="$HOME/.config/mako/themes/$THEME.conf"
[ -f "$MK" ] && cp "$MK" "$HOME/.config/mako/config" && makoctl reload 2>/dev/null

SO="$HOME/.config/swayosd/themes/$THEME.css"
if [ -f "$SO" ]; then
    cp "$SO" "$HOME/.config/swayosd/style.css"
    pkill swayosd-server 2>/dev/null
    setsid -f swayosd-server >/dev/null 2>&1
fi
