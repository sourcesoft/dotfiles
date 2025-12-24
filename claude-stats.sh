#!/bin/bash

CACHE_FILE="$HOME/.cache/ccstatusline-usage.txt"
LOCK_FILE="$HOME/.cache/ccstatusline-usage.lock"

# Function to generate progress bar
make_bar() {
  local pct="$1"
  local width=15
  local filled=$((pct * width / 100))
  local empty=$((width - filled))
  printf "["
  printf "█%.0s" $(seq 1 "$filled")
  printf "░%.0s" $(seq 1 "$empty")
  printf "]"
}

# Use cache if < 180 seconds old
if [[ -f "$CACHE_FILE" ]]; then
  AGE=$(($(date +%s) - $(stat -f '%m' "$CACHE_FILE")))
  [[ $AGE -lt 180 ]] && cat "$CACHE_FILE" && exit 0
fi

# Rate limit: only try API once per 30 seconds
if [[ -f "$LOCK_FILE" ]]; then
  LOCK_AGE=$(($(date +%s) - $(stat -f '%m' "$LOCK_FILE")))
  if [[ $LOCK_AGE -lt 30 ]]; then
    [[ -f "$CACHE_FILE" ]] && cat "$CACHE_FILE" && exit 0
    echo "[Timeout]" && exit 1
  fi
fi
touch "$LOCK_FILE"

TOKEN=$(security find-generic-password -s "Claude Code-credentials" -w 2>/dev/null | jq -r '.claudeAiOauth.accessToken // empty')
if [[ -z "$TOKEN" ]]; then
  [[ -f "$CACHE_FILE" ]] && cat "$CACHE_FILE" && exit 0
  echo "[No credentials]"
  exit 1
fi

RESPONSE=$(curl -s --max-time 5 "https://api.anthropic.com/api/oauth/usage" -H "Authorization: Bearer $TOKEN" -H "anthropic-beta: oauth-2025-04-20" 2>/dev/null)

if [[ -z "$RESPONSE" ]]; then
  [[ -f "$CACHE_FILE" ]] && cat "$CACHE_FILE" && exit 0
  echo "[API Error]"
  exit 1
fi

SESSION=$(echo "$RESPONSE" | jq -r '.five_hour.utilization // empty' 2>/dev/null)
WEEKLY=$(echo "$RESPONSE" | jq -r '.seven_day.utilization // empty' 2>/dev/null)

# If API failed, use stale cache or show error
if [[ -z "$SESSION" || -z "$WEEKLY" ]]; then
  [[ -f "$CACHE_FILE" ]] && cat "$CACHE_FILE" && exit 0
  echo "[Parse Error]"
  exit 1
fi

SESSION_INT=${SESSION%.*}
WEEKLY_INT=${WEEKLY%.*}

SESSION_BAR=$(make_bar "$SESSION_INT")
WEEKLY_BAR=$(make_bar "$WEEKLY_INT")

echo "Limit 5h: ${SESSION}% | Limit Weekly: ${WEEKLY}%" | tee "$CACHE_FILE"
