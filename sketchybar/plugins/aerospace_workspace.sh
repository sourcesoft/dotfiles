#!/usr/bin/env sh

CONFIG_ROOT="${CONFIG_DIR:-$HOME/.config/sketchybar}"
[ -r "$CONFIG_ROOT/colors.sh" ] && . "$CONFIG_ROOT/colors.sh"

: "${TEXT:=0xffffffff}"
: "${TEXT_DIM:=0xff7fa98d}"
: "${WORKSPACE_ACTIVE_BG:=0xffb63b3b}"
: "${WORKSPACE_OCCUPIED_BG:=0xff0d4f2a}"
: "${WORKSPACE_EMPTY_BG:=0xff08381e}"
: "${PULSE_BG:=0xff5eff6c}"

WORKSPACE="$1"
FOCUSED="${FOCUSED_WORKSPACE:-}"

if [ -z "$WORKSPACE" ]; then
  case "$NAME" in
    aerospace.workspace.*) WORKSPACE="${NAME##*.}" ;;
  esac
fi

if [ -z "$FOCUSED" ]; then
  FOCUSED="$(aerospace list-workspaces --focused --format '%{workspace}' 2>/dev/null)"
fi

if [ -z "$WORKSPACE" ]; then
  sketchybar --set "$NAME" label="${FOCUSED:-?}"
  exit 0
fi

OCCUPIED=0
if aerospace list-windows --workspace "$WORKSPACE" --format '%{window-id}' 2>/dev/null | grep -q .; then
  OCCUPIED=1
fi

BACKGROUND="$WORKSPACE_EMPTY_BG"
ICON_COLOR="$TEXT_DIM"

if [ "$WORKSPACE" = "$FOCUSED" ]; then
  BACKGROUND="$WORKSPACE_ACTIVE_BG"
  ICON_COLOR="$TEXT"
elif [ "$OCCUPIED" -eq 1 ]; then
  BACKGROUND="$WORKSPACE_OCCUPIED_BG"
  ICON_COLOR="$TEXT"
fi

if [ "$WORKSPACE" = "$FOCUSED" ] && [ "$SENDER" = "aerospace_workspace_change" ]; then
  sketchybar --animate tanh 8 --set "$NAME" background.color="$PULSE_BG" icon.color="$TEXT"
  sleep 0.12
  sketchybar --animate tanh 12 --set "$NAME" background.color="$BACKGROUND" icon.color="$ICON_COLOR"
else
  sketchybar --set "$NAME" background.color="$BACKGROUND" icon.color="$ICON_COLOR"
fi
