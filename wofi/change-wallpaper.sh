#!/bin/bash

# Folder wallpaper
WALLPAPER_DIR="$HOME/.config/hypr/wallpaper/"

# Pilih gambar via wofi
SELECTED=$(ls "$WALLPAPER_DIR" | wofi --dmenu --prompt "Pilih wallpaper:")
[ -z "$SELECTED" ] && exit

WALLPAPER="$WALLPAPER_DIR/$SELECTED"

# Simpan path buat swaylock
echo "$WALLPAPER" >~/.current_wallpaper

# Start swww-daemon kalau belum jalan
if ! pgrep -x "swww-daemon" >/dev/null; then
  swww-daemon &
  sleep 0.5
fi

# Deteksi session (Hyprland atau Niri)
SESSION=$(echo "$XDG_CURRENT_DESKTOP" | tr '[:upper:]' '[:lower:]')

if [[ "$SESSION" == *"hyprland"* ]]; then
  # HYPRLAND MODE
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
  # NIRI MODE (tidak ada output per monitor)
  swww img "$WALLPAPER" \
    --transition-type grow \
    --transition-step 120 \
    --transition-fps 120 \
    --transition-duration 1 \
    --transition-bezier 0.4,0.2,0.2,1.0
fi
