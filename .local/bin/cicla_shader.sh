#!/bin/bash

# Cicla manualmente tra gli shader GLSL di neowall.
# Uso:
#   cicla_shader.sh next     -> shader successivo (default)
#   cicla_shader.sh prev     -> shader precedente
#   cicla_shader.sh set NOME -> imposta uno shader specifico (es. topo.glsl)
#
# Riscrive la riga "shader" in config.vibe e riavvia il daemon neowall,
# poi mostra una notifica con il nome dello shader corrente.

set -euo pipefail

DIR_SHADER="$HOME/.config/neowall/shaders"
CONFIG="$HOME/.config/neowall/config.vibe"
DIREZIONE="${1:-next}"

# Lista ordinata degli shader disponibili (solo nomi file)
mapfile -t SHADER < <(find "$DIR_SHADER" -maxdepth 1 -type f -name '*.glsl' -printf '%f\n' | sort)
TOTALE=${#SHADER[@]}

if [ "$TOTALE" -eq 0 ]; then
  notify-send -t 3000 "NeoWall" "Nessuno shader trovato in $DIR_SHADER"
  exit 1
fi

# Shader attualmente impostato in config.vibe
CORRENTE=$(grep -oP '^\s*shader\s+\K\S+' "$CONFIG" | head -1 || true)

# Indice dello shader corrente nella lista
INDICE=0
for i in "${!SHADER[@]}"; do
  if [ "${SHADER[$i]}" = "$CORRENTE" ]; then
    INDICE=$i
    break
  fi
done

# Calcola il nuovo indice
case "$DIREZIONE" in
  next) INDICE=$(( (INDICE + 1) % TOTALE )) ;;
  prev) INDICE=$(( (INDICE - 1 + TOTALE) % TOTALE )) ;;
  set)
    NOME="${2:-}"
    [[ "$NOME" == *.glsl ]] || NOME="$NOME.glsl"
    TROVATO=-1
    for i in "${!SHADER[@]}"; do
      [ "${SHADER[$i]}" = "$NOME" ] && TROVATO=$i && break
    done
    if [ "$TROVATO" -lt 0 ]; then
      notify-send -t 3000 "NeoWall" "Shader '$NOME' non trovato"
      exit 1
    fi
    INDICE=$TROVATO
    ;;
  *)
    echo "Uso: $(basename "$0") [next|prev|set NOME]" >&2
    exit 1
    ;;
esac

NUOVO="${SHADER[$INDICE]}"

# Riscrivi la riga shader preservando l'indentazione
sed -i -E "s|^([[:space:]]*shader[[:space:]]+).*|\1$NUOVO|" "$CONFIG"

# Riavvia il daemon neowall per applicare lo shader
killall neowall 2>/dev/null || true
sleep 0.3
setsid neowall >/dev/null 2>&1 &

# Notifica a schermo con nome e posizione (dura qualche secondo)
NOME_BREVE="${NUOVO%.glsl}"
notify-send -t 3000 -a NeoWall "» Shader: $NOME_BREVE" "$((INDICE + 1)) / $TOTALE"
