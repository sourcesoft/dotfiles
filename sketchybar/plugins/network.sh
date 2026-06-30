#!/usr/bin/env sh

STATE_DIR="${TMPDIR:-/tmp}/sketchybar"
STATE_FILE="$STATE_DIR/network-${NAME:-network}"

format_rate() {
  awk -v bytes="$1" '
    BEGIN {
      if (bytes < 1024) {
        printf "%dB/s", bytes
      } else if (bytes < 1048576) {
        printf "%.0fK/s", bytes / 1024
      } else {
        printf "%.1fM/s", bytes / 1048576
      }
    }
  '
}

INTERFACE="$(route -n get default 2>/dev/null | awk '/interface:/{print $2; exit}')"
COUNTERS="$(netstat -ibn | awk -v iface="$INTERFACE" '
  $1 == iface && $3 ~ /^<Link/ && $7 ~ /^[0-9]+$/ && $10 ~ /^[0-9]+$/ {
    print $7, $10
    found = 1
    exit
  }
  END {
    if (!found) {
      exit 1
    }
  }
')"

if [ -z "$COUNTERS" ]; then
  COUNTERS="$(netstat -ibn | awk '
    $1 ~ /^en[0-9]+$/ && $3 ~ /^<Link/ && $7 ~ /^[0-9]+$/ && $10 ~ /^[0-9]+$/ {
      rx += $7
      tx += $10
    }
    END { print rx + 0, tx + 0 }
  ')"
fi

RX="${COUNTERS% *}"
TX="${COUNTERS#* }"
NOW="$(date +%s)"

mkdir -p "$STATE_DIR"

if [ -r "$STATE_FILE" ]; then
  read -r PREV_NOW PREV_RX PREV_TX < "$STATE_FILE"
else
  PREV_NOW="$NOW"
  PREV_RX="$RX"
  PREV_TX="$TX"
fi

printf '%s %s %s\n' "$NOW" "$RX" "$TX" > "$STATE_FILE"

ELAPSED=$((NOW - PREV_NOW))
if [ "$ELAPSED" -le 0 ]; then
  ELAPSED=1
fi

DOWN=$(((RX - PREV_RX) / ELAPSED))
UP=$(((TX - PREV_TX) / ELAPSED))

if [ "$DOWN" -lt 0 ]; then
  DOWN=0
fi

if [ "$UP" -lt 0 ]; then
  UP=0
fi

sketchybar --set "$NAME" label="↓$(format_rate "$DOWN") ↑$(format_rate "$UP")"
