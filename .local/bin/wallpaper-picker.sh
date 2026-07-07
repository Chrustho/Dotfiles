#!/bin/bash

# Selettore wallpaper manuale con anteprima (rofi a griglia).
# Mostra in un'unica griglia:
#   - gli shader GLSL di neowall (anteprima = thumb pre-renderizzata)
#   - le immagini statiche di ~/Immagini/Sfondi (anteprima nativa XDG)
#
# Lo shader si imposta con cicla_shader.sh; l'immagine con awww.
# Le thumb degli shader si generano con genera_thumb_shader.sh.

set -euo pipefail

SHADERDIR="$HOME/.config/neowall/shaders"
THUMBS="$HOME/.config/neowall/thumbs"
IMGDIR="$HOME/Immagini/Sfondi"
CICLA="$HOME/.local/bin/cicla_shader.sh"
THEME="$HOME/.config/rofi/wallpaper.rasi"

# Icone categoria (Nerd Font); la logica usa comunque i file, non l'icona.
IC_SHADER=""
IC_IMG=""

build_list() {
    # Shader
    find "$SHADERDIR" -maxdepth 1 -type f -name '*.glsl' -printf '%f\n' | sort | while read -r f; do
        n="${f%.glsl}"
        t="$THUMBS/$n.png"
        if [ -f "$t" ]; then
            printf '%s %s\0icon\x1f%s\n' "$IC_SHADER" "$n" "$t"
        else
            printf '%s %s\n' "$IC_SHADER" "$n"
        fi
    done
    # Immagini
    find "$IMGDIR" -maxdepth 1 -type f \
        \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' -o -iname '*.gif' \) \
        | sort | while read -r p; do
        b=$(basename "$p")
        printf '%s %s\0icon\x1fthumbnail://%s\n' "$IC_IMG" "$b" "$p"
    done
}

SEL=$(build_list | rofi -dmenu -i -show-icons -p ' Sfondo' -theme "$THEME")
[ -z "$SEL" ] && exit 0

# Rimuovi l'icona categoria iniziale -> resta il nome file
NAME="${SEL#* }"

if [ -f "$SHADERDIR/$NAME.glsl" ]; then
    # Shader: assicurati che neowall sia attivo, poi imposta
    pkill -f awww_slideshow.sh 2>/dev/null || true
    pgrep -x neowall >/dev/null 2>&1 || { setsid -f neowall >/dev/null 2>&1; sleep 0.3; }
    "$CICLA" set "$NAME" >/dev/null 2>&1
elif [ -f "$IMGDIR/$NAME" ]; then
    # Immagine: ferma slideshow e shader, applica con awww
    pkill -f awww_slideshow.sh 2>/dev/null || true
    killall neowall 2>/dev/null || true
    awww img "$IMGDIR/$NAME" \
        --transition-type random --transition-step 90 --transition-fps 120 2>/dev/null
    notify-send -t 2000 -a Sfondo "Sfondo impostato" "$NAME"
else
    notify-send -t 2000 -a Sfondo "Selezione non riconosciuta" "$NAME"
fi
