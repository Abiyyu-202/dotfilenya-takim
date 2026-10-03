#!/usr/bin/env bash
# Script cuaca Waybar dengan dukungan custom city & IP auto-detection

CITY_FILE="$HOME/.config/waybar/weather-city.txt"
CITY=""

if [[ -f "$CITY_FILE" ]]; then
    CITY=$(head -n 1 "$CITY_FILE" | xargs)
fi

if [[ -n "$CITY" ]]; then
    CITY_ENCODED=$(echo "$CITY" | tr ' ' '+')
    URL="https://wttr.in/${CITY_ENCODED}"
else
    URL="https://wttr.in/"
fi

for i in {1..4}; do
    text=$(curl -s -m 5 "${URL}?format=1" | sed -E 's/ +/ /g' | tr -d '\n')
    if [[ $? == 0 && -n "$text" && ! "$text" == *"Unknown location"* && ! "$text" == *"503"* && ! "$text" == *"<html>"* ]]; then
        tooltip=$(curl -s -m 5 "${URL}?format=4" | sed 's/"/\\"/g' | tr -d '\n')
        echo "{\"text\":\"$text\", \"tooltip\":\"$tooltip\n\nKlik: Ganti Lokasi\"}"
        exit 0
    fi
    sleep 1
done

echo "{\"text\":\"N/A\", \"tooltip\":\"Weather unavailable\n\nKlik: Ganti Lokasi\"}"
