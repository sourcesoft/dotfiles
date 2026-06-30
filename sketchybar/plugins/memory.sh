#!/usr/bin/env sh

MEMORY="$(vm_stat | awk '
  function clean(value) {
    gsub(/[^0-9]/, "", value)
    return value
  }

  /Pages free/ { free = clean($3) }
  /Pages active/ { active = clean($3) }
  /Pages inactive/ { inactive = clean($3) }
  /Pages speculative/ { speculative = clean($3) }
  /Pages wired down/ { wired = clean($4) }
  /Pages occupied by compressor/ { compressed = clean($5) }

  END {
    total = free + active + inactive + speculative + wired + compressed
    used = active + wired + compressed

    if (total <= 0) {
      print "0%"
    } else {
      printf("%d%%", (used / total * 100) + 0.5)
    }
  }
')"

sketchybar --set "$NAME" label="$MEMORY"
