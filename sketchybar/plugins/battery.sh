#!/usr/bin/env sh

CONFIG_ROOT="${CONFIG_DIR:-$HOME/.config/sketchybar}"
[ -r "$CONFIG_ROOT/colors.sh" ] && . "$CONFIG_ROOT/colors.sh"

: "${ITEM_BG:=0xff0d4f2a}"
: "${ALERT_BG:=0xffb63b3b}"

PERCENTAGE="$(pmset -g batt | grep -Eo '[0-9]+%' | cut -d% -f1 | head -n 1)"
CHARGING="$(pmset -g batt | grep 'AC Power')"

if [ -z "$PERCENTAGE" ]; then
  exit 0
fi

case "$PERCENTAGE" in
  9[0-9]|100) ICON="" ;;
  [6-8][0-9]) ICON="" ;;
  [3-5][0-9]) ICON="" ;;
  [1-2][0-9]) ICON="" ;;
  *) ICON="" ;;
esac

if [ -n "$CHARGING" ]; then
  ICON=""
fi

BACKGROUND="$ITEM_BG"
if [ "$PERCENTAGE" -lt 10 ]; then
  BACKGROUND="$ALERT_BG"
fi

sketchybar --set "$NAME" icon="$ICON" label="${PERCENTAGE}%" background.color="$BACKGROUND"
