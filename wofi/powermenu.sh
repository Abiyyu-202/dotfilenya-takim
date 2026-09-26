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
  if [ -n "$NIRI_SOCKET" ] || [[ "$XDG_CURRENT_DESKTOP" == *"niri"* ]]; then
    niri msg action quit -s
    exit
  fi

  # Hyprland logout
  if [ -n "$HYPRLAND_INSTANCE_SIGNATURE" ] || [[ "$XDG_CURRENT_DESKTOP" == *"Hyprland"* ]]; then
    hyprctl dispatch exit
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
