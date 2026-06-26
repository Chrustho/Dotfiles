#!/bin/bash

# Toggle neowall / sfondo statico

if pgrep -x "neowall" >/dev/null; then
  killall neowall
else
  neowall &
fi
