#!/bin/bash
for bat in /sys/class/power_supply/BAT*; do
    if [[ -f "$bat/capacity" ]]; then
        capacity=$(cat "$bat/capacity")
        status=$(cat "$bat/status" 2>/dev/null)
        case "$status" in
            Charging)    printf '{"text": "%s%% ⚡", "class": "charging"}\n' "$capacity" ;;
            Full)        printf '{"text": "Full", "class": "full"}\n' ;;
            Discharging) printf '{"text": "%s%%", "class": "discharging"}\n' "$capacity" ;;
            *)           printf '{"text": "%s%%", "class": "unknown"}\n' "$capacity" ;;
        esac
        exit 0
    fi
done
printf '{"text": "", "class": "none"}\n'
