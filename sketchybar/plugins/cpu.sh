#!/usr/bin/env sh

CONFIG_ROOT="${CONFIG_DIR:-$HOME/.config/sketchybar}"
[ -r "$CONFIG_ROOT/colors.sh" ] && . "$CONFIG_ROOT/colors.sh"

: "${ITEM_BG:=0xff0d4f2a}"
: "${ALERT_BG:=0xffb63b3b}"

CORES="$(sysctl -n hw.logicalcpu 2>/dev/null)"
CPU="$(ps -A -o %cpu= | awk -v cores="${CORES:-1}" '
  { total += $1 }
  END {
    if (cores <= 0) cores = 1
    usage = total / cores
    printf("%d", usage + 0.5)
  }
')"

BACKGROUND="$ITEM_BG"
if [ "${CPU:-0}" -ge 100 ]; then
  BACKGROUND="$ALERT_BG"
fi

sketchybar --set "$NAME" label="${CPU}%" background.color="$BACKGROUND"
