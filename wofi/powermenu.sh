#!/bin/bash

choice=$(printf "Shutdown\nReboot\nLogout\nSuspend\nLock" | wofi --dmenu --prompt "Power")

case "$choice" in
Shutdown)
  systemctl poweroff
  ;;

Reboot)
  systemctl reboot
  ;;

Logout)
  # Niri logout
  if command -v niri session >/dev/null 2>&1; then
    niri session close-all
    exit
  fi

  # Hyprland logout
  if command -v hyprctl >/dev/null 2>&1; then
    hyprctl dispatch exit 0
    exit
  fi

  # Fallback universal
  loginctl terminate-user "$USER"
  ;;

Suspend)
  systemctl suspend
  ;;

Lock)
  # Eksekusi script lockscreen milikmu
  hyprlock
  ;;
esac
