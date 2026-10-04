#!/usr/bin/env bash
# Smooth OSD notifications for Volume and Brightness via SwayNC / libnotify

get_volume() {
    local raw
    raw=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null)
    if [[ -z "$raw" ]]; then
        echo "0"
        return
    fi

    if [[ "$raw" == *"[MUTED]"* ]]; then
        echo "muted"
        return
    fi

    local num
    num=$(echo "$raw" | awk '{print $2}')
    awk -v n="$num" 'BEGIN { printf "%d", (n * 100) + 0.5 }'
}

get_brightness() {
    brightnessctl -m 2>/dev/null | cut -d',' -f4 | tr -d '%'
}

show_volume_osd() {
    local vol
    vol=$(get_volume)
    if [[ "$vol" == "muted" ]]; then
        notify-send -u low -t 1000 \
            -h string:x-canonical-private-synchronous:osd \
            -h int:value:0 \
            -i audio-volume-muted-symbolic \
            "Volume" "Muted"
    else
        local icon="audio-volume-high-symbolic"
        if (( vol < 30 )); then
            icon="audio-volume-low-symbolic"
        elif (( vol < 70 )); then
            icon="audio-volume-medium-symbolic"
        fi

        notify-send -u low -t 1000 \
            -h string:x-canonical-private-synchronous:osd \
            -h int:value:"$vol" \
            -i "$icon" \
            "Volume" "${vol}%"
    fi
}

show_brightness_osd() {
    local bri
    bri=$(get_brightness)
    notify-send -u low -t 1000 \
        -h string:x-canonical-private-synchronous:osd \
        -h int:value:"$bri" \
        -i display-brightness-symbolic \
        "Brightness" "${bri}%"
}

case "$1" in
    volume-up)
        wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+
        show_volume_osd
        ;;
    volume-down)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
        show_volume_osd
        ;;
    volume-mute)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        show_volume_osd
        ;;
    mic-mute)
        wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
        local mic_raw
        mic_raw=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ 2>/dev/null)
        if [[ "$mic_raw" == *"[MUTED]"* ]]; then
            notify-send -u low -t 1000 \
                -h string:x-canonical-private-synchronous:osd \
                -i microphone-disabled-symbolic \
                "Microphone" "Muted"
        else
            notify-send -u low -t 1000 \
                -h string:x-canonical-private-synchronous:osd \
                -i audio-input-microphone-symbolic \
                "Microphone" "Active"
        fi
        ;;
    brightness-up)
        brightnessctl -s set +5% >/dev/null 2>&1
        show_brightness_osd
        ;;
    brightness-down)
        brightnessctl -s set 5%- >/dev/null 2>&1
        show_brightness_osd
        ;;
    *)
        echo "Usage: $0 {volume-up|volume-down|volume-mute|mic-mute|brightness-up|brightness-down}"
        exit 1
        ;;
esac
