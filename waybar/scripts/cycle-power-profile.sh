#!/usr/bin/env bash
# Quick cycle through power profiles (performance -> balanced -> power-saver)

current=$(powerprofilesctl get 2>/dev/null || echo "balanced")
case "$current" in
    performance)
        next="balanced"
        desc="Balanced"
        ;;
    balanced)
        next="power-saver"
        desc="Power Saver"
        ;;
    power-saver)
        next="performance"
        desc="Performance"
        ;;
    *)
        next="balanced"
        desc="Balanced"
        ;;
esac

powerprofilesctl set "$next"
notify-send -u low -i preferences-system-power "Mode Daya" "Mode $desc Diaktifkan"
