#!/usr/bin/env bash
# Power Profiles Selector via wofi and powerprofilesctl

current=$(powerprofilesctl get 2>/dev/null || echo "balanced")

perf_label="󰓅   Performance"
bal_label="󰈐   Balanced"
saver_label="󰌪   Power Saver"

case "$current" in
    performance) perf_label="󰓅   Performance  (Aktif)" ;;
    balanced)    bal_label="󰈐   Balanced  (Aktif)" ;;
    power-saver) saver_label="󰌪   Power Saver  (Aktif)" ;;
esac

options=$(printf "%s\n%s\n%s" "$perf_label" "$bal_label" "$saver_label")

choice=$(echo "$options" | wofi --dmenu \
    --prompt "Mode Daya" \
    --lines 3 \
    --define key_up=Up,k,Ctrl-k \
    --define key_down=Down,j,Ctrl-j \
    --define key_exit=Escape,q)

case "$choice" in
    *Performance*)
        powerprofilesctl set performance
        notify-send -u low -i preferences-system-power "Mode Daya" "Mode Performance Diaktifkan"
        ;;
    *Balanced*)
        powerprofilesctl set balanced
        notify-send -u low -i preferences-system-power "Mode Daya" "Mode Balanced Diaktifkan"
        ;;
    *Power*Saver*|*power-saver*)
        powerprofilesctl set power-saver
        notify-send -u low -i preferences-system-power "Mode Daya" "Mode Power Saver Diaktifkan"
        ;;
esac
