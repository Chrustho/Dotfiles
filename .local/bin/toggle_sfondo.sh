#!/bin/bash

# Controlla se neowall è in esecuzione
if pgrep -x "neowall" >/dev/null; then
  # Se è acceso, uccidilo (mostrando swaybg sotto)
  killall neowall
else
  # Se è spento, riaccendilo (coprendo swaybg)
  neowall &
fi
