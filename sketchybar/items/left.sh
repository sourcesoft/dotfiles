#!/usr/bin/env sh

sketchybar --add item aerospace.layout left \
           --set aerospace.layout update_freq=5 \
                                  icon.drawing=off \
                                  padding_left=1 \
                                  background.corner_radius=0 \
                                  script="$PLUGIN_DIR/aerospace_layout.sh" \
           --subscribe aerospace.layout aerospace_workspace_change aerospace_layout_change \
           --add item front_app left \
           --set front_app icon.drawing=off \
                            padding_left=8 \
                            label.padding_left=8 \
                            label.padding_right=10 \
                            label.color="$TEXT_INVERSE" \
                            background.color="$TEXT" \
                            background.border_width=0 \
                            script="$PLUGIN_DIR/front_app.sh" \
           --subscribe front_app front_app_switched
