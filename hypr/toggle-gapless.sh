#!/bin/bash

STATE_FILE=/tmp/hypr-gapstate

if [ -f "$STATE_FILE" ]; then
  if ! hyprctl eval 'hl.config({ general = { gaps_in = 5, gaps_out = 9 }, decoration = { rounding = 7 } })' >/dev/null 2>&1; then
    hyprctl keyword general:gaps_in 5
    hyprctl keyword general:gaps_out 9
    hyprctl keyword decoration:rounding 7
  fi
  rm -f "$STATE_FILE"
  notify-send "Gapless disable"
else
  if ! hyprctl eval 'hl.config({ general = { gaps_in = 0, gaps_out = 0 }, decoration = { rounding = 0 } })' >/dev/null 2>&1; then
    hyprctl keyword general:gaps_in 0
    hyprctl keyword general:gaps_out 0
    hyprctl keyword decoration:rounding 0
  fi
  touch "$STATE_FILE"
  notify-send "Gapless enable"
fi
