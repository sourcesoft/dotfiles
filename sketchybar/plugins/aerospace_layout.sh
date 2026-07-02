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
MODE="$(aerospace list-modes --current 2>/dev/null)"

case "$ROOT_LAYOUT" in
  h_tiles) ROOT_STATE="HTiles" ;;
  v_tiles) ROOT_STATE="VTiles" ;;
  h_accordion) ROOT_STATE="HAccordion" ;;
  v_accordion) ROOT_STATE="VAccordion" ;;
  *tiles*) ROOT_STATE="Tiles" ;;
  *accordion*) ROOT_STATE="Accordion" ;;
  *) ROOT_STATE="${ROOT_LAYOUT:-Layout}" ;;
esac

if [ "$FULLSCREEN" = "true" ]; then
  WINDOW_STATE="Full"
else
  case "$WINDOW_LAYOUT" in
    floating) WINDOW_STATE="Float" ;;
    "") WINDOW_STATE="None" ;;
    *) WINDOW_STATE="Tile" ;;
  esac
fi

case "$NAME" in
  aerospace.window_state)
    LAYOUT="$WINDOW_STATE"
    ;;
  *)
    if [ -n "$MODE" ] && [ "$MODE" != "main" ]; then
      LAYOUT="SVC $ROOT_STATE"
    else
      LAYOUT="$ROOT_STATE"
    fi
    ;;
esac

if [ "$SENDER" = "aerospace_layout_change" ] || [ "$SENDER" = "aerospace_workspace_change" ] || [ "$SENDER" = "aerospace_mode_change" ]; then
  sketchybar --animate tanh 8 --set "$NAME" background.color="$PULSE_BG"
  sleep 0.12
  sketchybar --animate tanh 12 --set "$NAME" label="$LAYOUT" background.color="$ITEM_BG"
else
  sketchybar --set "$NAME" label="$LAYOUT" background.color="$ITEM_BG"
fi
