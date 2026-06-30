#!/usr/bin/env sh

CONFIG_ROOT="${CONFIG_DIR:-$HOME/.config/sketchybar}"
[ -r "$CONFIG_ROOT/colors.sh" ] && . "$CONFIG_ROOT/colors.sh"

: "${ITEM_BG:=0xff0d4f2a}"
: "${PULSE_BG:=0xff5eff6c}"

INFO="$(aerospace list-windows --focused --format '%{window-is-fullscreen}|%{window-layout}|%{workspace-root-container-layout}' 2>/dev/null)"

if [ -z "$INFO" ]; then
  WORKSPACE="$(aerospace list-workspaces --focused --format '%{workspace}' 2>/dev/null)"
  INFO="$(aerospace list-windows --workspace "$WORKSPACE" --format 'false|%{window-layout}|%{workspace-root-container-layout}' 2>/dev/null | head -n 1)"
fi

FULLSCREEN="$(printf '%s' "$INFO" | cut -d '|' -f 1)"
WINDOW_LAYOUT="$(printf '%s' "$INFO" | cut -d '|' -f 2)"
ROOT_LAYOUT="$(printf '%s' "$INFO" | cut -d '|' -f 3)"

if [ "$FULLSCREEN" = "true" ]; then
  LAYOUT="Full"
else
  case "$WINDOW_LAYOUT" in
    floating) LAYOUT="Float" ;;
    *accordion*) LAYOUT="Accordion" ;;
    *tiles*) LAYOUT="Tiles" ;;
    *)
      case "$ROOT_LAYOUT" in
        *accordion*) LAYOUT="Accordion" ;;
        *tiles*) LAYOUT="Tiles" ;;
        *) LAYOUT="${WINDOW_LAYOUT:-Layout}" ;;
      esac
      ;;
  esac
fi

if [ "$SENDER" = "aerospace_layout_change" ] || [ "$SENDER" = "aerospace_workspace_change" ]; then
  sketchybar --animate tanh 8 --set "$NAME" background.color="$PULSE_BG"
  sleep 0.12
  sketchybar --animate tanh 12 --set "$NAME" label="$LAYOUT" background.color="$ITEM_BG"
else
  sketchybar --set "$NAME" label="$LAYOUT" background.color="$ITEM_BG"
fi
