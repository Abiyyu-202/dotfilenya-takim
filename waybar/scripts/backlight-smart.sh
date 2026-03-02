#!/usr/bin/env bash
STATE_FILE="/tmp/waybar-brightness-smart.state"
NOW=$(date +%s)

brightness=$(brightnessctl -m 2>/dev/null | awk -F, 'NR==1 {gsub(/%/, "", $4); print $4}')
current_value="${brightness:-0}"
display_text="${current_value}%"

if (( current_value <= 33 )); then
    icon="󰃞"
elif (( current_value <= 66 )); then
    icon="󰃟"
else
    icon="󰃠"
fi

previous_value=""
last_change=0
[[ -f "$STATE_FILE" ]] && IFS='|' read -r previous_value last_change < "$STATE_FILE"

[[ "$current_value" != "$previous_value" ]] && last_change=$NOW
printf '%s|%s\n' "$current_value" "$last_change" > "$STATE_FILE"

if (( NOW - last_change <= 1 )); then
    printf '{"text":"%s  %s","class":"expanded","tooltip":"󰃠  Brightness: %s"}\n' "$icon" "$display_text" "$display_text"
else
    printf '{"text":"%s","class":"collapsed","tooltip":"󰃠  Brightness: %s"}\n' "$icon" "$display_text"
fi
