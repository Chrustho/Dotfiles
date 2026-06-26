#!/bin/bash

# Slideshow sfondi con awww

DIR_SFONDI="$HOME/Immagini/Sfondi"
INTERVALLO=300

sleep 2

while true; do
  SFONDO=$(find "$DIR_SFONDI" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.gif" -o -name "*.jpeg" -o -name "*.webp" \) | shuf -n 1)

  if [ -n "$SFONDO" ]; then
    awww img "$SFONDO" \
      --transition-type random \
      --transition-step 90 \
      --transition-fps 120
  fi

  sleep $INTERVALLO
done
