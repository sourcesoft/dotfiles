#!/usr/bin/env sh

CORES="$(sysctl -n hw.logicalcpu 2>/dev/null)"
CPU="$(ps -A -o %cpu= | awk -v cores="${CORES:-1}" '
  { total += $1 }
  END {
    usage = total / cores
    if (usage > 100) usage = 100
    printf("%d%%", usage + 0.5)
  }
')"

sketchybar --set "$NAME" label="$CPU"
