#!/bin/bash

# Definisci le opzioni del menu con le icone
opzioni="  Spegni\n  Riavvia\n  Sospendi\n  Blocca\n  Esci (Logout)"
# Passa le opzioni a fuzzel (in modalità dmenu) e salva la scelta dell'utente
scelta=$(echo -e "$opzioni" | rofi -dmenu -theme ~/.config/rofi/powermenu.rasi)
# Esegui il comando corrispondente alla scelta
case "$scelta" in
"  Spegni")
  systemctl poweroff
  ;;
"  Riavvia")
  systemctl reboot
  ;;
" Sospendi")
  systemctl suspend
  ;;
"  Blocca")
  # Se usi un locker diverso (es. hyprlock), cambialo qui sotto
  hyprlock
  ;;
"  Esci (Logout)")
  # Comando specifico per chiudere Niri in modo pulito
  niri msg action quit
  ;;
*)
  # Se l'utente preme Esc o chiude Fuzzel, non fare nulla
  exit 0
  ;;
esac
