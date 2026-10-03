#!/usr/bin/env bash
# Selector dan input lokasi cuaca Waybar via wofi

CITY_FILE="$HOME/.config/waybar/weather-city.txt"
CURRENT=""
if [[ -f "$CITY_FILE" ]]; then
    CURRENT=$(head -n 1 "$CITY_FILE" | xargs)
fi

CURRENT_LABEL="Otomatis (IP)"
[[ -n "$CURRENT" ]] && CURRENT_LABEL="$CURRENT"

OPTIONS=$(cat <<EOF
  Otomatis (Deteksi IP)
󰔄  Magelang
󰔄  Yogyakarta
󰔄  Sleman
󰔄  Bantul
󰔄  Kulon Progo
󰔄  Gunungkidul
󰔄  Solo
󰔄  Klaten
󰔄  Purworejo
󰔄  Semarang
󰔄  Salatiga
󰔄  Jakarta
󰔄  Bandung
󰔄  Surabaya
󰔄  Malang
󰏫  Tulis Kota Lainnya...
EOF
)

CHOICE=$(echo "$OPTIONS" | wofi --dmenu \
    --prompt "Lokasi Cuaca (Saat ini: $CURRENT_LABEL)" \
    --lines 9 \
    --define key_up=Up,k,Ctrl-k \
    --define key_down=Down,j,Ctrl-j \
    --define key_exit=Escape,q)

# Keluar jika dibatalkan (Esc)
[[ -z "$CHOICE" ]] && exit 0

NEW_CITY=""
case "$CHOICE" in
    *Otomatis*)
        NEW_CITY=""
        ;;
    *Tulis*Kota*Lainnya*)
        # Buka dialog input teks zenity
        NEW_CITY=$(zenity --entry --title "Lokasi Cuaca" --text "Masukkan nama kota:" 2>/dev/null)
        [[ -z "$NEW_CITY" ]] && exit 0
        ;;
    󰔄*)
        # Ambil nama kota setelah ikon
        NEW_CITY=$(echo "$CHOICE" | sed -E 's/^[^ ]+ +//' | xargs)
        ;;
    *)
        NEW_CITY=$(echo "$CHOICE" | xargs)
        ;;
esac

if [[ -z "$NEW_CITY" ]]; then
    rm -f "$CITY_FILE"
    notify-send -u low -i weather-few-clouds "Cuaca Waybar" "Lokasi diatur otomatis (Deteksi IP)"
else
    echo "$NEW_CITY" > "$CITY_FILE"
    notify-send -u low -i weather-few-clouds "Cuaca Waybar" "Lokasi diatur ke: $NEW_CITY"
fi

# Refresh modul custom/weather Waybar secara instan via signal 8
pkill -RTMIN+8 waybar 2>/dev/null || pkill -SIGRTMIN+8 waybar 2>/dev/null
