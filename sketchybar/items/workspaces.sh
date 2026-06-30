#!/usr/bin/env sh

AEROSPACE_WORKSPACES="A S D F Q W E R T X"
AEROSPACE_WORKSPACE_ITEMS=""
WORKSPACE_MONITORS="$(aerospace list-workspaces --all --format '%{workspace}|%{monitor-id}' 2>/dev/null)"
MONITORS="$(aerospace list-monitors --format '%{monitor-id}' 2>/dev/null | sort -n)"
GROUP_COUNT=0
WORKSPACE_WIDTH=26
WORKSPACE_GROUP_EDGE_PADDING=4

workspace_monitor() {
  printf '%s\n' "$WORKSPACE_MONITORS" | awk -F'|' -v workspace="$1" '$1 == workspace { print $2; exit }'
}

monitor_exists() {
  for monitor in $MONITORS; do
    if [ "$monitor" = "$1" ]; then
      return 0
    fi
  done

  return 1
}

add_workspace_group_edge() {
  side="$1"
  item="aerospace.workspace.group.$GROUP_COUNT.$side"
  AEROSPACE_WORKSPACE_ITEMS="$AEROSPACE_WORKSPACE_ITEMS $item"

  sketchybar --add item "$item" left \
             --set "$item" icon.drawing=off \
                            label.drawing=off \
                            padding_left=0 \
                            padding_right=0 \
                            width=1 \
                            background.drawing=on \
                            background.color="$TEXT" \
                            background.corner_radius=0 \
                            background.height="${BAR_HEIGHT:-30}" \
                            background.padding_left=0 \
                            background.padding_right=0 \
                            background.border_width=0
}

end_workspace_group() {
  add_workspace_group_edge right
  GROUP_COUNT=$((GROUP_COUNT + 1))
}

workspace_icon() {
  case "$1" in
    A) printf '%s\n' "" ;;
    D) printf '%s\n' "" ;;
    F) printf '%s\n' "" ;;
    Q) printf '%s\n' "" ;;
    S) printf '%s\n' "" ;;
    W) printf '%s\n' "" ;;
    E) printf '%s\n' "" ;;
    R) printf '%s\n' "" ;;
    T) printf '%s\n' "" ;;
    X) printf '%s\n' "" ;;
  esac
}

add_workspace_item() {
  workspace="$1"
  left_padding="${2:-0}"
  right_padding="${3:-0}"
  item="aerospace.workspace.$workspace"
  workspace_icon="$(workspace_icon "$workspace")"
  item_width=$((WORKSPACE_WIDTH + left_padding + right_padding))
  AEROSPACE_WORKSPACE_ITEMS="$AEROSPACE_WORKSPACE_ITEMS $item"

  sketchybar --add item "$item" left \
             --set "$item" update_freq=10 \
                            icon="$workspace_icon" \
                            icon.font="Symbols Nerd Font:Regular:14.0" \
                            icon.width="$item_width" \
                            icon.align=center \
                            icon.padding_left=0 \
                            icon.padding_right=0 \
                            background.image.drawing=off \
                            label.drawing=off \
                            width="$item_width" \
                            padding_left=1 \
                            padding_right=1 \
                            background.corner_radius=0 \
                            background.padding_left=0 \
                            background.padding_right=0 \
                            background.border_width=0 \
                            script="$PLUGIN_DIR/aerospace_workspace.sh" \
                            click_script="aerospace workspace $workspace" \
             --subscribe "$item" aerospace_workspace_change
}

add_workspace_group() {
  group_workspaces="$1"
  first_workspace=""
  last_workspace=""

  for workspace in $group_workspaces; do
    if [ -z "$first_workspace" ]; then
      first_workspace="$workspace"
    fi

    last_workspace="$workspace"
  done

  for workspace in $group_workspaces; do
    left_padding=0
    right_padding=0

    if [ "$workspace" = "$first_workspace" ]; then
      left_padding="$WORKSPACE_GROUP_EDGE_PADDING"
    fi

    if [ "$workspace" = "$last_workspace" ]; then
      right_padding="$WORKSPACE_GROUP_EDGE_PADDING"
    fi

    add_workspace_item "$workspace" "$left_padding" "$right_padding"
  done

  end_workspace_group
}

if [ -z "$WORKSPACE_MONITORS" ] || [ -z "$MONITORS" ]; then
  add_workspace_group "$AEROSPACE_WORKSPACES"
else
  for monitor in $MONITORS; do
    GROUP_WORKSPACES=""

    for workspace in $AEROSPACE_WORKSPACES; do
      if [ "$(workspace_monitor "$workspace")" = "$monitor" ]; then
        GROUP_WORKSPACES="$GROUP_WORKSPACES $workspace"
      fi
    done

    if [ -n "$GROUP_WORKSPACES" ]; then
      add_workspace_group "$GROUP_WORKSPACES"
    fi
  done

  HAS_FALLBACK_GROUP=0
  for workspace in $AEROSPACE_WORKSPACES; do
    monitor="$(workspace_monitor "$workspace")"
    if [ -z "$monitor" ] || ! monitor_exists "$monitor"; then
      HAS_FALLBACK_GROUP=1
      break
    fi
  done

  if [ "$HAS_FALLBACK_GROUP" -eq 1 ]; then
    GROUP_WORKSPACES=""

    for workspace in $AEROSPACE_WORKSPACES; do
      monitor="$(workspace_monitor "$workspace")"
      if [ -z "$monitor" ] || ! monitor_exists "$monitor"; then
        GROUP_WORKSPACES="$GROUP_WORKSPACES $workspace"
      fi
    done

    add_workspace_group "$GROUP_WORKSPACES"
  fi
fi

export AEROSPACE_WORKSPACE_ITEMS
