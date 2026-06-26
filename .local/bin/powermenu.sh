#!/bin/bash

# Menu power via rofi

opzioni="  Spegni\n  Riavvia\n  Sospendi\n  Blocca\n  Esci (Logout)"
scelta=$(echo -e "$opzioni" | rofi -dmenu -theme ~/.config/rofi/powermenu.rasi)
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
  hyprlock
  ;;
"  Esci (Logout)")
  niri msg action quit
  ;;
*)
  exit 0
  ;;
esac
