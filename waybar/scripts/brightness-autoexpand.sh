#!/usr/bin/env bash

STATE_FILE="/tmp/waybar-brightness-autoexpand.state"
NOW=$(date +%s)

brightness=$(brightnessctl -m 2>/dev/null | awk -F, 'NR==1 {gsub(/%/, "", $4); print $4 "%"}')
current_value="${brightness:-0%}"
display_text="$current_value"

previous_value=""
last_change=0
if [[ -f "$STATE_FILE" ]]; then
    IFS='|' read -r previous_value last_change < "$STATE_FILE"
fi

if [[ "$current_value" != "$previous_value" ]]; then
    last_change=$NOW
fi

printf '%s|%s\n' "$current_value" "$last_change" > "$STATE_FILE"

if (( NOW - last_change <= 1 )); then
    printf '{"text":"%s","class":["expanded"]}\n' "$display_text"
else
    printf '{"text":"","class":["collapsed"]}\n'
fi
