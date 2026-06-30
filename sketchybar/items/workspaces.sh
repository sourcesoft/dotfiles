#!/usr/bin/env sh

AEROSPACE_WORKSPACES="D F W E S T X A Q R"
AEROSPACE_WORKSPACE_ITEMS=""

for workspace in $AEROSPACE_WORKSPACES; do
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
done

export AEROSPACE_WORKSPACE_ITEMS
