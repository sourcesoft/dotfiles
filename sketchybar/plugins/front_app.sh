#!/usr/bin/env sh

if [ "$SENDER" = "front_app_switched" ] && [ -n "$INFO" ]; then
  APP="$INFO"
else
  APP="$(osascript -e 'tell application "System Events" to get name of first application process whose frontmost is true' 2>/dev/null)"
fi

sketchybar --set "$NAME" label="${APP:-App}"
