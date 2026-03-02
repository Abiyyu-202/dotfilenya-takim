#!/usr/bin/env bash

STATE_FILE="/tmp/waybar-audio-autoexpand.state"
NOW=$(date +%s)

volume=$(pactl get-sink-volume @DEFAULT_SINK@ 2>/dev/null | grep -oE '[0-9]+%' | head -n1)
mute_state=$(pactl get-sink-mute @DEFAULT_SINK@ 2>/dev/null | awk '{print $2}')

if [[ "$mute_state" == "yes" ]]; then
    current_value="muted"
    display_text="Muted"
else
    current_value="${volume:-0%}"
    display_text="$current_value"
fi

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
