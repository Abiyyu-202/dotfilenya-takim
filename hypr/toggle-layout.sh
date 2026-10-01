#!/bin/bash
# Toggle between Hyprland layouts (dwindle and master)

CURRENT=$(hyprctl getoption general:layout 2>/dev/null | awk '/^str:/ {print $2}')

if [ "$CURRENT" = "dwindle" ]; then
    NEXT="master"
else
    NEXT="dwindle"
fi

# Apply via eval (for Lua parser), fallback to keyword (for legacy parser)
if ! hyprctl eval "hl.config({ general = { layout = \"$NEXT\" } })" >/dev/null 2>&1; then
    hyprctl keyword general:layout "$NEXT" >/dev/null 2>&1 || true
fi

notify-send -t 1500 -a "Hyprland" "Layout Switched" "Active layout: $NEXT"
