#!/usr/bin/env sh

SOURCE="$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources 2>/dev/null | awk -F' = ' '
  /KeyboardLayout Name/ {
    value = $2
    gsub(/[;"]/, "", value)
    print value
    exit
  }
  /Input Mode/ {
    value = $2
    gsub(/[;"]/, "", value)
    sub(/^.*\./, "", value)
    print value
    exit
  }
  /InputSourceName/ {
    value = $2
    gsub(/[;"]/, "", value)
    print value
    exit
  }
')"

ABBR="$(printf '%s' "${SOURCE:-Input}" | tr '[:lower:]' '[:upper:]' | sed 's/[^A-Z]//g' | cut -c 1-3)"

sketchybar --set "$NAME" label="${ABBR:-INP}"
