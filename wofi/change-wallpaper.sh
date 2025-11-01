#!/bin/bash

# Folder tempat wallpaper disimpan
WALLPAPER_DIR="/home/toheartz/.config/hypr/wallpaper/"

# Pilih gambar dengan wofi
SELECTED=$(ls "$WALLPAPER_DIR" | wofi --dmenu --prompt "Pilih wallpaper:")

# Kalau batal, keluar
[ -z "$SELECTED" ] && exit

# Path penuh ke gambar
WALLPAPER="$WALLPAPER_DIR/$SELECTED"

# Simpan path wallpaper ke file agar swaylock bisa pakai juga
echo "$WALLPAPER" >~/.current_wallpaper

# Kill hyprpaper biar reload config baru
pkill hyprpaper

# Buat config baru
CONFIG="$HOME/.config/hypr/hyprpaper.conf"
echo "preload = $WALLPAPER" >"$CONFIG"

# Ambil semua monitor aktif dan apply wallpaper ke semuanya
hyprctl monitors | grep "Monitor" | awk '{print $2}' | while read -r MONITOR; do
  echo "wallpaper = $MONITOR,$WALLPAPER" >>"$CONFIG"
done

# Jalankan ulang hyprpaper
hyprpaper &
