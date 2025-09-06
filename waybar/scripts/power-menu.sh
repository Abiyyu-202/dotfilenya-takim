#!/bin/bash
entries="⏼ Logout\n⏻ Shutdown\n↻ Restart\n⏾ Suspend"

chosen=$(echo -e "$entries" | wofi --dmenu --width 250 --height 210 --prompt "Power Menu" | awk '{print $2}')

case "$chosen" in
    Logout)
        hyprctl dispatch exit ;;
    Shutdown)
        systemctl poweroff ;;
    Restart)
        systemctl reboot ;;
    Suspend)
        systemctl suspend ;;
esac
