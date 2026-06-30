#!/usr/bin/env sh

AEROSPACE_WORKSPACES="D F W E S T X A Q R"
AEROSPACE_WORKSPACE_ITEMS=""
WORKSPACE_MONITORS="$(aerospace list-workspaces --all --format '%{workspace}|%{monitor-id}' 2>/dev/null)"
MONITORS="$(aerospace list-monitors --format '%{monitor-id}' 2>/dev/null | sort -n)"
GROUP_COUNT=0

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

add_monitor_gap() {
  item="aerospace.workspace.gap.$GROUP_COUNT"
  AEROSPACE_WORKSPACE_ITEMS="$AEROSPACE_WORKSPACE_ITEMS $item"

  sketchybar --add item "$item" left \
             --set "$item" icon.drawing=off \
                            label.drawing=off \
                            background.drawing=off \
                            padding_left=0 \
                            padding_right=0 \
                            width=8
}

add_workspace_item() {
  workspace="$1"
  item="aerospace.workspace.$workspace"
  AEROSPACE_WORKSPACE_ITEMS="$AEROSPACE_WORKSPACE_ITEMS $item"

  sketchybar --add item "$item" left \
             --set "$item" update_freq=10 \
                            icon="$workspace" \
                            icon.font="SF Pro:Semibold:12.0" \
                            icon.padding_left=7 \
                            icon.padding_right=7 \
                            label.drawing=off \
                            width=26 \
                            padding_left=1 \
                            padding_right=1 \
                            background.corner_radius=0 \
                            background.border_width=1 \
                            background.border_color="$TEXT" \
                            script="$PLUGIN_DIR/aerospace_workspace.sh" \
                            click_script="aerospace workspace $workspace" \
             --subscribe "$item" aerospace_workspace_change
}

if [ -z "$WORKSPACE_MONITORS" ] || [ -z "$MONITORS" ]; then
  for workspace in $AEROSPACE_WORKSPACES; do
    add_workspace_item "$workspace"
  done
else
  for monitor in $MONITORS; do
    HAS_GROUP=0

    for workspace in $AEROSPACE_WORKSPACES; do
      if [ "$(workspace_monitor "$workspace")" = "$monitor" ]; then
        HAS_GROUP=1
        break
      fi
    done

    if [ "$HAS_GROUP" -eq 1 ]; then
      if [ "$GROUP_COUNT" -gt 0 ]; then
        add_monitor_gap
      fi

      for workspace in $AEROSPACE_WORKSPACES; do
        if [ "$(workspace_monitor "$workspace")" = "$monitor" ]; then
          add_workspace_item "$workspace"
        fi
      done

      GROUP_COUNT=$((GROUP_COUNT + 1))
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
    if [ "$GROUP_COUNT" -gt 0 ]; then
      add_monitor_gap
    fi

    for workspace in $AEROSPACE_WORKSPACES; do
      monitor="$(workspace_monitor "$workspace")"
      if [ -z "$monitor" ] || ! monitor_exists "$monitor"; then
        add_workspace_item "$workspace"
      fi
    done
  fi
fi

export AEROSPACE_WORKSPACE_ITEMS
