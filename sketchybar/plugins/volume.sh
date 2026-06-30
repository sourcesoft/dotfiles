#!/usr/bin/env sh

CONFIG_ROOT="${CONFIG_DIR:-$HOME/.config/sketchybar}"
[ -r "$CONFIG_ROOT/colors.sh" ] && . "$CONFIG_ROOT/colors.sh"

: "${ITEM_BG:=0xff0d4f2a}"
: "${ALERT_BG:=0xffb63b3b}"

if [ "$SENDER" = "volume_change" ] && [ -n "$INFO" ]; then
  VOLUME="$INFO"
  MUTED="false"
else
  SETTINGS="$(osascript -e 'set volumeSettings to get volume settings' -e 'return (output volume of volumeSettings as text) & "," & (output muted of volumeSettings as text)' 2>/dev/null)"
  VOLUME="${SETTINGS%,*}"
  MUTED="${SETTINGS#*,}"
fi

if [ -z "$VOLUME" ]; then
  exit 0
fi

SILENT="$(awk -v volume="$VOLUME" -v muted="$MUTED" 'BEGIN { print (muted == "true" || volume + 0 <= 0) ? 1 : 0 }')"

if [ "$SILENT" = "1" ]; then
  ICON="󰖁"
else
  case "$VOLUME" in
    [6-9][0-9]|100) ICON="󰕾" ;;
    [3-5][0-9]) ICON="󰖀" ;;
    *) ICON="󰕿" ;;
  esac
fi

BACKGROUND="$ITEM_BG"
if [ "$SILENT" = "1" ]; then
  BACKGROUND="$ALERT_BG"
fi

sketchybar --set "$NAME" icon="$ICON" label="$VOLUME%" background.color="$BACKGROUND"
