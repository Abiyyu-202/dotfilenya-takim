#!/bin/bash
for bat in /sys/class/power_supply/BAT*; do
    [[ -f "$bat/capacity" ]] || continue

    capacity=$(cat "$bat/capacity")
    status=$(cat "$bat/status" 2>/dev/null)

    # Calculate time remaining
    time_str=""
    current=0
    charge=0
    full=0

    [[ -f "$bat/current_now" ]] && current=$(cat "$bat/current_now")
    [[ -f "$bat/charge_now" ]] && charge=$(cat "$bat/charge_now")
    [[ -f "$bat/charge_full" ]] && full=$(cat "$bat/charge_full")

    if [[ "$current" -gt 0 ]]; then
        if [[ "$status" == "Discharging" && "$charge" -gt 0 ]]; then
            mins=$(( charge * 60 / current ))
        elif [[ "$status" == "Charging" && "$full" -gt 0 ]]; then
            remaining=$(( full - charge ))
            [[ "$remaining" -lt 0 ]] && remaining=0
            mins=$(( remaining * 60 / current ))
        fi

        if [[ -n "$mins" && "$mins" -gt 0 ]]; then
            hrs=$(( mins / 60 ))
            m=$(( mins % 60 ))
            if [[ "$hrs" -gt 0 ]]; then
                time_str=$(printf ' %dh%02dm' "$hrs" "$m")
            else
                time_str=$(printf ' %dm' "$m")
            fi
        fi
    fi

    case "$status" in
        Charging)    printf '{"text": "%s%% %s", "class": "charging"}\n' "$capacity" "$time_str" ;;
        Full)        printf '{"text": "Full", "class": "full"}\n' ;;
        Discharging) printf '{"text": "%s%%%s", "class": "discharging"}\n' "$capacity" "$time_str" ;;
        *)           printf '{"text": "%s%%", "class": "unknown"}\n' "$capacity" ;;
    esac
    exit 0
done
printf '{"text": "", "class": "none"}\n'
