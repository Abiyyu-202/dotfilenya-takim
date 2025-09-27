#!/bin/bash
# Script untuk custom window title di Waybar + Hyprland
# Output: App class/title jika ada active window, empty jika kosong

active_window=$(hyprctl activewindow -j 2>/dev/null)
if [ -z "$active_window" ] || [ "$active_window" = "null" ]; then
    echo ""  # Kosong jika no window
    exit 0
fi

# Parse JSON: Ambil class atau title (kamu bisa ganti ke '.title' jika mau full title)
class=$(echo "$active_window" | jq -r '.class // empty')
title=$(echo "$active_window" | jq -r '.title // empty' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//' | cut -c1-50)  # Trim & limit 50 chars

if [ -n "$class" ] && [ "$class" != "null" ]; then
    # Format mirip hyprland/window: Icon sederhana + title (sesuaikan icon berdasarkan class jika mau)
    case "$class" in
        "firefox") icon="" ;;
        "code") icon="󰨞" ;;  # VS Code
        "kitty"|"alacritty") icon="" ;;  # Terminal
        *) icon="" ;;  # Default icon
    esac
    echo "$icon $title"  # Output: Icon + title (max 50 chars)
else
    echo ""  # Fallback empty
fi