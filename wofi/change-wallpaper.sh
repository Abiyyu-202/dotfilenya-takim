#!/bin/bash

WALLPAPER_DIR="$HOME/.config/hypr/wallpaper/"

SELECTED=$(ls "$WALLPAPER_DIR" | wofi --dmenu --prompt "Pilih wallpaper:")
[ -z "$SELECTED" ] && exit

WALLPAPER="$WALLPAPER_DIR/$SELECTED"

cp "$WALLPAPER" "$HOME/.cache/wallpaper_rn.png"
echo "$WALLPAPER" >"$HOME/.current_wallpaper"

if ! pgrep -x "swww-daemon" >/dev/null; then
  swww-daemon &
  sleep 0.5
fi

SESSION=$(echo "$XDG_CURRENT_DESKTOP" | tr '[:upper:]' '[:lower:]')

if [[ "$SESSION" == *"hyprland"* ]]; then
  # HYPRLAND
  MONITORS=$(hyprctl monitors -j | jq -r '.[].name')

  for MON in $MONITORS; do
    swww img "$WALLPAPER" \
      --outputs "$MON" \
      --transition-type grow \
      --transition-step 120 \
      --transition-fps 120 \
      --transition-duration 1 \
      --transition-bezier 0.4,0.2,0.2,1.0
  done

else
  # NIRI
  swww img "$WALLPAPER" \
    --transition-type grow \
    --transition-step 120 \
    --transition-fps 120 \
    --transition-duration 1 \
    --transition-bezier 0.4,0.2,0.2,1.0
fi
