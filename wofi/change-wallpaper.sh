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
WOFI_CONFIG="$HOME/.config/wofi/wallpaper-config"
WOFI_STYLE="$HOME/.config/wofi/wallpaper-style.css"
THUMB_DIR="$HOME/.cache/wallpaper-thumbs"

mkdir -p "$THUMB_DIR"

# Generate thumbnails with filename burned at the bottom
ENTRIES=""
for img in "$WALLPAPER_DIR"/*; do
  filename=$(basename "$img")
  label="${filename}"
  thumb="$THUMB_DIR/${filename}"

  # Only regenerate if thumbnail is missing or older than original
  if [ ! -f "$thumb" ] || [ "$img" -nt "$thumb" ]; then
    magick "$img" -resize 340x190^ -gravity center -extent 340x190 \
      -gravity south \
      -fill "rgba(0,0,0,0.6)" -draw "rectangle 0,160,340,190" \
      -fill white -font "JetBrains-Mono-NL-Regular-Nerd-Font-Complete-Mono" \
      -pointsize 11 -gravity south -annotate +0+4 "$label" \
      "$thumb" 2>/dev/null || \
    magick "$img" -resize 340x190^ -gravity center -extent 340x190 \
      -gravity south \
      -fill "rgba(0,0,0,0.6)" -draw "rectangle 0,160,340,190" \
      -fill white -pointsize 11 -gravity south -annotate +0+4 "$label" \
      "$thumb"
  fi

  ENTRIES+="img:${thumb}:text:${filename}"$'\n'
done

SELECTED=$(
  echo -e "$ENTRIES" | $WOFI --conf "$WOFI_CONFIG" --style "$WOFI_STYLE"
)

[ -z "$SELECTED" ] && exit 0

# Extract the original filename from the selection
SELECTED_FILE=$(echo "$SELECTED" | sed 's|.*:text:||')
WALLPAPER="$WALLPAPER_DIR/$SELECTED_FILE"

cp "$WALLPAPER" "$HOME/.cache/wallpaper_rn.png"
echo "$WALLPAPER" >"$HOME/.current_wallpaper"

$SWWW img "$WALLPAPER" \
  --transition-type grow \
  --transition-step 120 \
  --transition-fps 120 \
  --transition-duration 1 \
  --transition-bezier 0.4,0.2,0.2,1.0
