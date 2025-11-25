#!/bin/bash

STATE_FILE=/tmp/hypr-gapstate

if [ -f "$STATE_FILE" ]; then
  hyprctl keyword general:gaps_in 5
  hyprctl keyword general:gaps_out 9
  hyprctl keyword decoration:rounding 0
  rm "$STATE_FILE"
  notify-send "Gapless disable"
else
  hyprctl keyword general:gaps_in 0
  hyprctl keyword general:gaps_out 0
  hyprctl keyword decoration:rounding 0
  touch "$STATE_FILE"
  notify-send "Gapless enable"
fi
