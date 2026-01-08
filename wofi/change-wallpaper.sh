#!/bin/bash

export XDG_RUNTIME_DIR="/run/user/$(id -u)"

if [ -z "$WAYLAND_DISPLAY" ]; then
  WAYLAND_DISPLAY=$(ls "$XDG_RUNTIME_DIR" | grep -E '^wayland-[0-9]+' | head -n1)
  export WAYLAND_DISPLAY
fi

SWWW="/usr/bin/swww"
WOFI="/usr/bin/wofi"
HYPRCTL="/usr/bin/hyprctl"
JQ="/usr/bin/jq"

WALLPAPER_DIR="$HOME/.config/hypr/wallpaper"

SELECTED=$(
  ls "$WALLPAPER_DIR" | $WOFI --dmenu --prompt "Pilih wallpaper:"
)

[ -z "$SELECTED" ] && exit 0

WALLPAPER="$WALLPAPER_DIR/$SELECTED"

cp "$WALLPAPER" "$HOME/.cache/wallpaper_rn.png"
echo "$WALLPAPER" >"$HOME/.current_wallpaper"

$SWWW img "$WALLPAPER" \
  --transition-type grow \
  --transition-step 120 \
  --transition-fps 120 \
  --transition-duration 1 \
  --transition-bezier 0.4,0.2,0.2,1.0
