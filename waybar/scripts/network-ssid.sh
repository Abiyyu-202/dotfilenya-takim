#!/bin/bash
# Try WiFi SSID first
ssid=$(nmcli -t -f active,ssid dev wifi 2>/dev/null | grep '^yes' | cut -d: -f2)

if [[ -n "$ssid" ]]; then
    printf '{"text": "%s", "class": "wifi"}\n' "$ssid"
    exit 0
fi

# Fallback: check for ethernet
eth=$(nmcli -t -f type,state,connection dev 2>/dev/null | grep '^ethernet:connected' | cut -d: -f3)
if [[ -n "$eth" ]]; then
    printf '{"text": "Ethernet", "class": "ethernet"}\n'
    exit 0
fi

printf '{"text": "Offline", "class": "disconnected"}\n'
