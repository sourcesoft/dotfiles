#!/usr/bin/env sh

CONFIG_ROOT="${CONFIG_DIR:-$HOME/.config/sketchybar}"
[ -r "$CONFIG_ROOT/colors.sh" ] && . "$CONFIG_ROOT/colors.sh"

: "${ITEM_BG:=0xff0d4f2a}"
: "${ALERT_BG:=0xffb63b3b}"

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
      print "0"
    } else {
      printf("%d", (used / total * 100) + 0.5)
    }
  }
')"

BACKGROUND="$ITEM_BG"
if [ "${MEMORY:-0}" -ge 100 ]; then
  BACKGROUND="$ALERT_BG"
fi

sketchybar --set "$NAME" label="${MEMORY}%" background.color="$BACKGROUND"
