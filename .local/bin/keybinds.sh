#!/bin/sh

# Mostra TUTTI i keybind di niri in un'unica lista rofi, ricercabile.
# Estrae le combinazioni e la descrizione dal blocco `binds { }` di config.kdl
# (usa hotkey-overlay-title se presente, altrimenti l'azione tra graffe).

CONFIG="$HOME/.config/niri/config.kdl"
THEME="$HOME/.config/rofi/keybinds.rasi"

awk '
/^[[:space:]]*binds[[:space:]]*\{/ { inb=1; next }
inb && /^[[:space:]]*\}/ { inb=0 }
inb {
    line=$0
    if (line ~ /^[[:space:]]*\/\//) next     # commenti
    if (line ~ /^[[:space:]]*$/)    next     # vuote
    if (line !~ /\{/)               next     # solo righe con azione

    # combinazione tasti = primo token
    key=line
    sub(/^[[:space:]]+/, "", key)
    sub(/[[:space:]].*/, "", key)

    # descrizione
    if (match(line, /hotkey-overlay-title="[^"]*"/)) {
        d=substr(line, RSTART, RLENGTH)
        gsub(/hotkey-overlay-title="/, "", d)
        sub(/"$/, "", d)
    } else {
        d=line
        sub(/^[^{]*\{/, "", d)           # tutto dopo la prima {
        sub(/\}[^}]*$/, "", d)           # togli ultima } e oltre
        gsub(/^[[:space:]]+|[[:space:]]+$/, "", d)
        sub(/;[[:space:]]*$/, "", d)
        gsub(/"/, "", d)
    }
    printf "%-28s  %s\n", key, d
}
' "$CONFIG" | rofi -dmenu -i -p '  Keybinds' -theme "$THEME"
