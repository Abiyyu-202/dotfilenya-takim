#!/usr/bin/env bash
# Quick toggle for hotspot 'yure1x'

if nmcli -t -f name,type,state con show --active | grep -q "^yure1x:"; then
    nmcli con down "yure1x"
    notify-send -u normal -i network-wireless "Hotspot" "Hotspot 'yure1x' dinonaktifkan"
else
    nmcli con up "yure1x"
    notify-send -u normal -i network-wireless "Hotspot" "Hotspot 'yure1x' aktif"
fi
