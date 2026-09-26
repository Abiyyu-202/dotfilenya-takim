#!/bin/bash
# Start wallpaper daemon if not running
if ! pgrep -x "awww-daemon" >/dev/null; then
    awww-daemon &
    sleep 0.6
fi

# Load wallpaper from ~/.current_wallpaper or fallback
WALLPAPER=""
if [ -f "$HOME/.current_wallpaper" ]; then
    WALLPAPER=$(cat "$HOME/.current_wallpaper")
fi

if [ -z "$WALLPAPER" ] || [ ! -f "$WALLPAPER" ]; then
    WALLPAPER="$HOME/.config/hypr/wallpaper/arch-minimal.png"
    echo "$WALLPAPER" > "$HOME/.current_wallpaper"
    mkdir -p "$HOME/.cache"
    cp "$WALLPAPER" "$HOME/.cache/wallpaper_rn.png"
fi

awww img "$WALLPAPER" \
    --transition-type grow \
    --transition-step 120 \
    --transition-fps 120 \
    --transition-duration 1 \
    --transition-bezier 0.4,0.2,0.2,1.0
