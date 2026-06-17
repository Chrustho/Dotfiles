#!/bin/bash

# --- CONFIGURAZIONE ---
DIR_SFONDI="$HOME/Immagini/Sfondi"
INTERVALLO=300 # Tempo tra uno sfondo e l'altro in secondi (300 = 5 minuti)

# Aspetta un attimo all'avvio per assicurarsi che awww-daemon sia pronto
sleep 2

# Ciclo infinito che cambia lo sfondo
while true; do
  # Cerca tutte le immagini nella cartella e ne sceglie una a caso
  SFONDO=$(find "$DIR_SFONDI" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.gif" -o -name "*.jpeg" -o -name "*.webp" \) | shuf -n 1)

  if [ -n "$SFONDO" ]; then
    # Applica lo sfondo usando awww con transizioni casuali
    awww img "$SFONDO" \
      --transition-type random \
      --transition-step 90 \
      --transition-fps 120
  fi

  # Mette in pausa lo script per il tempo stabilito
  sleep $INTERVALLO
done
