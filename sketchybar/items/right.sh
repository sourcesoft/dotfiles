#!/usr/bin/env sh

sketchybar --add item battery right \
           --set battery update_freq=120 \
                         script="$PLUGIN_DIR/battery.sh" \
           --subscribe battery system_woke power_source_change \
           --add item volume right \
           --set volume script="$PLUGIN_DIR/volume.sh" \
           --subscribe volume volume_change \
           --add item clock right \
           --set clock update_freq=10 \
                       icon="" \
                       script="$PLUGIN_DIR/clock.sh" \
           --add item calendar right \
           --set calendar update_freq=60 \
                          icon="󰃭" \
                          script="$PLUGIN_DIR/calendar.sh" \
           --add item input right \
           --set input update_freq=5 \
                       icon="󰌌" \
                       script="$PLUGIN_DIR/input.sh" \
           --add item memory right \
           --set memory update_freq=5 \
                         icon="MEM" \
                         icon.font="SF Pro:Semibold:11.0" \
                         script="$PLUGIN_DIR/memory.sh" \
           --add item cpu right \
           --set cpu update_freq=5 \
                     icon="CPU" \
                     icon.font="SF Pro:Semibold:11.0" \
                     script="$PLUGIN_DIR/cpu.sh" \
           --add item network right \
           --set network update_freq=3 \
                          icon="NET" \
                          icon.font="SF Pro:Semibold:11.0" \
                          script="$PLUGIN_DIR/network.sh"
