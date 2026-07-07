#!/bin/bash

# Genera (una tantum) le anteprime PNG degli shader GLSL di neowall, per il
# selettore wallpaper rofi. Gli shader non hanno thumbnailer XDG, quindi si
# cattura un frame con `niri msg action screenshot-screen` e si ridimensiona
# con ffmpeg.
#
# Uso:
#   genera_thumb_shader.sh           -> genera solo le thumb mancanti
#   genera_thumb_shader.sh --force   -> rigenera tutte
#
# NOTA: eseguire da un workspace VUOTO (o dall'overview) cosi' la cattura
# riprende solo lo sfondo e non le finestre aperte.

set -euo pipefail

DIR_SHADER="$HOME/.config/neowall/shaders"
THUMBS="$HOME/.config/neowall/thumbs"
SHOTDIR="${HOME}/Immagini/Schermate"
CONFIG="$HOME/.config/neowall/config.vibe"
CICLA="$HOME/.local/bin/cicla_shader.sh"
FORCE="${1:-}"

mkdir -p "$THUMBS" "$SHOTDIR"

command -v ffmpeg >/dev/null 2>&1 || { notify-send "Thumb shader" "ffmpeg non installato"; exit 1; }

CORRENTE=$(grep -oP '^\s*shader\s+\K\S+' "$CONFIG" | head -1 || true)

mapfile -t SHADER < <(find "$DIR_SHADER" -maxdepth 1 -type f -name '*.glsl' -printf '%f\n' | sort)
TOT=${#SHADER[@]}
i=0

for s in "${SHADER[@]}"; do
    i=$((i + 1))
    name="${s%.glsl}"
    out="$THUMBS/$name.png"
    [ -f "$out" ] && [ "$FORCE" != "--force" ] && continue

    notify-send -t 1500 -a NeoWall "Anteprima shader $i/$TOT" "$name"
    "$CICLA" set "$s" >/dev/null 2>&1 || continue
    sleep 1.6

    niri msg action screenshot-screen >/dev/null 2>&1 || true
    sleep 0.4

    shot=$(find "$SHOTDIR" -maxdepth 1 -type f -name '*.png' -printf '%T@ %p\n' 2>/dev/null \
        | sort -nr | head -1 | cut -d' ' -f2-)

    if [ -n "$shot" ] && [ -f "$shot" ]; then
        ffmpeg -y -loglevel error -i "$shot" -vf "scale=480:-1" "$out" </dev/null || true
        rm -f "$shot"
    fi
done

[ -n "$CORRENTE" ] && "$CICLA" set "$CORRENTE" >/dev/null 2>&1 || true
notify-send -t 2500 -a NeoWall "Anteprime shader pronte" "$THUMBS"
