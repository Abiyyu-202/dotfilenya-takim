#!/usr/bin/env bash
# Lokasi default otomatis dari IP publik (bisa di-override dengan export WEATHER_CITY="NamaKota")
CITY="${WEATHER_CITY:-}"
URL="https://wttr.in/${CITY}"

for i in {1..5}; do
    text=$(curl -s -m 5 "${URL}?format=1" | sed -E 's/ +/ /g' | tr -d '\n')
    if [[ $? == 0 && -n "$text" && ! "$text" == *"Unknown location"* && ! "$text" == *"503"* ]]; then
        tooltip=$(curl -s -m 5 "${URL}?format=4" | sed 's/"/\\"/g' | tr -d '\n')
        echo "{\"text\":\"$text\", \"tooltip\":\"$tooltip\"}"
        exit 0
    fi
    sleep 2
done
echo "{\"text\":\"N/A\", \"tooltip\":\"Weather unavailable\"}"
