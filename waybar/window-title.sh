#!/bin/bash
# Optimized script for custom window title

# Get the active window JSON directly, more efficiently
active_window=$(hyprctl -j activewindow 2>/dev/null)

# Check if the result is valid and non-empty much faster
if [[ -z "$active_window" || "$active_window" == "null" || "$active_window" == "{}" ]]; then
    echo ""
    exit 0
fi

# Use jq to extract class and title in a single call
class=$(echo "$active_window" | jq -r '.class')
title=$(echo "$active_window" | jq -r '.title // ""' | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' -e 's/"/"/g' | cut -c1-50)

# Simple icon mapping
case "${class^^}" in
    "FIREFOX") icon="" ;;
    "CODE"|"CODE - INSIDERS") icon="󰨞" ;;
    "KITTY"|"ALACRITTY") icon="" ;;
    *) icon="" ;;
esac

# Only output if there's a title to show
if [[ -n "$title" ]]; then
    echo "{\"text\": \"$icon $title\", \"tooltip\": \"$class: $title\"}"
else
    echo ""
fi