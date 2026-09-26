#!/bin/bash

choice=$(printf "   Shutdown\n   Reboot\n󰍃   Logout\n   Suspend\n   Lock" | wofi --dmenu --prompt "Power" --lines 5 --define key_up=Up,k,Ctrl-k --define key_down=Down,j,Ctrl-j --define key_exit=Escape,q)

case "$choice" in
*Shutdown*)
  systemctl poweroff
  ;;

*Reboot*)
  systemctl reboot
  ;;

*Logout*)
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

*Suspend*)
  systemctl suspend
  ;;

*Lock*)
  # Eksekusi script lockscreen milikmu
  hyprlock
  ;;
esac
