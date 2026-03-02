#!/usr/bin/env bash
STATE_FILE="/tmp/waybar-network-smart.state"
NOW=$(date +%s)

wifi_ssid=$(nmcli -t -f active,ssid dev wifi 2>/dev/null | awk -F: '$1=="yes" {print $2; exit}')
if [[ -n "$wifi_ssid" ]]; then
    current_value="wifi:$wifi_ssid"
    icon="󰤨"
    detail="$wifi_ssid"
    tooltip="  $wifi_ssid"
else
    eth=$(nmcli -t -f type,state dev 2>/dev/null | awk -F: '$1=="ethernet" && $2=="connected" {found=1; exit} END {exit !found}' && echo "yes")
    if [[ "$eth" == "yes" ]]; then
        current_value="ethernet"
        icon="󰌗"
        detail="Ethernet"
        tooltip="󰌗  Ethernet"
    else
        current_value="offline"
        icon="󰤭"
        detail="Offline"
        tooltip="󰤭  Disconnected"
    fi
fi

previous_value=""
last_change=0
[[ -f "$STATE_FILE" ]] && IFS='|' read -r previous_value last_change < "$STATE_FILE"

[[ "$current_value" != "$previous_value" ]] && last_change=$NOW
printf '%s|%s\n' "$current_value" "$last_change" > "$STATE_FILE"

if (( NOW - last_change <= 1 )); then
    printf '{"text":"%s  %s","class":"expanded","tooltip":"%s"}\n' "$icon" "$detail" "$tooltip"
else
    printf '{"text":"%s","class":"collapsed","tooltip":"%s"}\n' "$icon" "$tooltip"
fi
