#!/usr/bin/env sh

CONFIG_ROOT="${CONFIG_DIR:-$HOME/.config/sketchybar}"
[ -r "$CONFIG_ROOT/colors.sh" ] && . "$CONFIG_ROOT/colors.sh"

: "${ITEM_BG:=0xff0d4f2a}"
: "${TEXT:=0xffffffff}"
: "${TEXT_INVERSE:=0xff000000}"

STATE_DIR="${TMPDIR:-/tmp}/sketchybar"
PID_FILE="$STATE_DIR/caffeinate.pid"
ITEM_NAME="${NAME:-caffeinate}"

read_pid() {
  [ -r "$PID_FILE" ] || return 1
  read -r pid < "$PID_FILE"
  case "$pid" in
    ''|*[!0-9]*) return 1 ;;
    *) printf '%s\n' "$pid" ;;
  esac
}

caffeinate_is_running() {
  pid="$(read_pid)" || return 1
  command="$(ps -p "$pid" -o command= 2>/dev/null | awk 'NR == 1 { print $1 }')"
  command="${command##*/}"

  [ "$command" = "caffeinate" ]
}

wait_for_caffeinate() {
  tries=0

  while [ "$tries" -lt 5 ]; do
    if caffeinate_is_running; then
      return 0
    fi

    tries=$((tries + 1))
    sleep 0.05
  done

  return 1
}

start_caffeinate() {
  mkdir -p "$STATE_DIR"
  nohup /usr/bin/caffeinate -d -i >/dev/null 2>&1 &
  printf '%s\n' "$!" > "$PID_FILE"
  wait_for_caffeinate
}

stop_caffeinate() {
  pid="$(read_pid)" || {
    rm -f "$PID_FILE"
    return
  }

  if caffeinate_is_running; then
    kill "$pid" 2>/dev/null
  fi

  rm -f "$PID_FILE"
}

case "$1" in
  toggle)
    if caffeinate_is_running; then
      stop_caffeinate
    else
      start_caffeinate
    fi
    ;;
esac

if caffeinate_is_running; then
  sketchybar --set "$ITEM_NAME" \
    background.color="$TEXT" \
    icon.color="$TEXT_INVERSE"
else
  rm -f "$PID_FILE"
  sketchybar --set "$ITEM_NAME" \
    background.color="$ITEM_BG" \
    icon.color="$TEXT"
fi
