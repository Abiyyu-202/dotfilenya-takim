#!/usr/bin/env bash

STATE_FILE="/tmp/waybar-network-autoexpand.state"
NOW=$(date +%s)

wifi_ssid=$(nmcli -t -f active,ssid dev wifi 2>/dev/null | awk -F: '$1=="yes" {print $2; exit}')
if [[ -n "$wifi_ssid" ]]; then
    current_value="wifi:$wifi_ssid"
    display_text="$wifi_ssid"
    type_class="wifi"
else
    ethernet_name=$(nmcli -t -f type,state,connection dev 2>/dev/null | awk -F: '$1=="ethernet" && $2=="connected" {print $3; exit}')
    if [[ -n "$ethernet_name" ]]; then
        current_value="ethernet:$ethernet_name"
        display_text="Ethernet"
        type_class="ethernet"
    else
        current_value="offline"
        display_text="Offline"
        type_class="disconnected"
    fi
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
    printf '{"text":"%s","class":["expanded","%s"]}\n' "$display_text" "$type_class"
else
    printf '{"text":"","class":["collapsed","%s"]}\n' "$type_class"
fi
