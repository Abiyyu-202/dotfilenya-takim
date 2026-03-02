#!/usr/bin/env bash
STATE_FILE="/tmp/waybar-audio-smart.state"
NOW=$(date +%s)

volume=$(pactl get-sink-volume @DEFAULT_SINK@ 2>/dev/null | grep -oE '[0-9]+%' | head -n1)
mute=$(pactl get-sink-mute @DEFAULT_SINK@ 2>/dev/null | awk '{print $2}')
vol_num=${volume//%/}
vol_num=${vol_num:-0}

if [[ "$mute" == "yes" ]]; then
    icon="󰝟"
    current_value="muted"
    detail="Muted"
elif (( vol_num <= 33 )); then
    icon="󰕿"
    current_value="vol:$volume"
    detail="$volume"
elif (( vol_num <= 66 )); then
    icon="󰖀"
    current_value="vol:$volume"
    detail="$volume"
else
    icon="󰕾"
    current_value="vol:$volume"
    detail="$volume"
fi

previous_value=""
last_change=0
[[ -f "$STATE_FILE" ]] && IFS='|' read -r previous_value last_change < "$STATE_FILE"

[[ "$current_value" != "$previous_value" ]] && last_change=$NOW
printf '%s|%s\n' "$current_value" "$last_change" > "$STATE_FILE"

if (( NOW - last_change <= 1 )); then
    printf '{"text":"%s  %s","class":"expanded","tooltip":"󰕾  %s"}\n' "$icon" "$detail" "$detail"
else
    printf '{"text":"%s","class":"collapsed","tooltip":"󰕾  %s"}\n' "$icon" "$detail"
fi
