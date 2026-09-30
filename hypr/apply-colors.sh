#!/bin/bash
# Intelligent color generation using Matugen
# Automatically detects monochrome/grayscale wallpapers to prevent blue/lavender fallback

WALLPAPER="$1"
if [ -z "$WALLPAPER" ] && [ -f "$HOME/.current_wallpaper" ]; then
    WALLPAPER=$(cat "$HOME/.current_wallpaper")
fi

[ -z "$WALLPAPER" ] || [ ! -f "$WALLPAPER" ] && exit 0

THUMB="$HOME/.cache/wallpaper_picker/thumbs/$(basename "$WALLPAPER")"
TARGET_IMG="$WALLPAPER"
[ -f "$THUMB" ] && TARGET_IMG="$THUMB"

SATURATION=$(magick "$TARGET_IMG" -sample 64x64 -colorspace HSL -channel G -separate +channel -format "%[fx:mean]" info: 2>/dev/null || echo "1")
IS_MONO=$(awk -v sat="$SATURATION" 'BEGIN { print (sat < 0.03) ? "1" : "0" }')

if [ "$IS_MONO" = "1" ]; then
    matugen image "$WALLPAPER" --mode dark --type scheme-monochrome --source-color-index 0
else
    matugen image "$WALLPAPER" --mode dark --source-color-index 0
fi
