#!/usr/bin/env sh

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

if [ "$MUTED" = "true" ] || [ "$VOLUME" = "0" ]; then
  ICON="󰖁"
else
  case "$VOLUME" in
    [6-9][0-9]|100) ICON="󰕾" ;;
    [3-5][0-9]) ICON="󰖀" ;;
    *) ICON="󰕿" ;;
  esac
fi

sketchybar --set "$NAME" icon="$ICON" label="$VOLUME%"
