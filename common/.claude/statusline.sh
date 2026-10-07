#!/bin/bash
input=$(cat)

CWD=$(echo "$input" | jq -r '.cwd // ""')
MODEL=$(echo "$input" | jq -r '.model.display_name // "Unknown"')
CTX_PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
FIVE_H=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // 0' | cut -d. -f1)
SEVEN_D=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // 0' | cut -d. -f1)

# Folder name + git branch
DIR_NAME="${CWD##*/}"
[ -z "$DIR_NAME" ] && DIR_NAME="$CWD"
MAGENTA=$'\033[35m'
DIM_B=$'\033[2m'
RESET_B=$'\033[0m'
BRANCH=""
if git -C "$CWD" rev-parse --git-dir > /dev/null 2>&1; then
  BRANCH_NAME=$(git -C "$CWD" --no-optional-locks branch --show-current 2>/dev/null)
  [ -n "$BRANCH_NAME" ] && BRANCH=" ${DIM_B}on${RESET_B} ${MAGENTA}${BRANCH_NAME}${RESET_B}"
fi

# Color bar: green <50%, yellow 50-80%, red >80%
bar() {
  local pct=${1:-0}
  local width=8
  local filled=$(( pct * width / 100 ))
  [ "$filled" -gt "$width" ] && filled=$width

  if [ "$pct" -lt 50 ]; then
    color=$'\033[32m'
  elif [ "$pct" -lt 80 ]; then
    color=$'\033[33m'
  else
    color=$'\033[31m'
  fi
  local dim=$'\033[2m'
  local reset=$'\033[0m'

  local out="${color}"
  for ((i=0; i<filled; i++)); do out+="█"; done
  out+="${dim}"
  for ((i=filled; i<width; i++)); do out+="░"; done
  out+="${reset}"
  printf '%b' "$out"
}

DIM=$'\033[2m'
RESET=$'\033[0m'

COST=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
YELLOW=$'\033[33m'
COST_FMT=$(printf '$%.2f' "$COST")

printf "%s%b ${DIM}|${RESET} %s ${DIM}(${RESET}%d%% ${DIM}·${RESET} ${YELLOW}%s${RESET}${DIM})${RESET} ${DIM}|${RESET} 5h: %b %3d%% ${DIM}|${RESET} 7d: %b %3d%%\n" \
  "$DIR_NAME" "$BRANCH" "$MODEL" "$CTX_PCT" "$COST_FMT" "$(bar "$FIVE_H")" "$FIVE_H" "$(bar "$SEVEN_D")" "$SEVEN_D"
