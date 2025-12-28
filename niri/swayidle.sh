#!/bin/sh

exec swayidle -w \
  timeout 130 'niri msg action power-off-monitors' \
  timeout 120 'hyprlock' \
  resume 'niri msg action power-on-monitors' \
  before-sleep 'niri msg action power-off-monitors'
