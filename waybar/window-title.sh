#!/bin/bash
# Unified window title script (Hyprland + Niri + NVIM) — UTF-8 SAFE

# Detect compositor
if [[ -n "$HYPRLAND_INSTANCE_SIGNATURE" ]] && command -v hyprctl >/dev/null 2>&1; then
  json=$(hyprctl -j activewindow 2>/dev/null)
  class=$(jq -r '.class // ""' <<<"$json")
  title=$(jq -r '.title // ""' <<<"$json")
elif command -v niri-msg >/dev/null 2>&1; then
  json=$(niri-msg -j focused-window 2>/dev/null)
  class=$(jq -r '.app_id // ""' <<<"$json")
  title=$(jq -r '.title // ""' <<<"$json")
else
  exit 0
fi

# Validation
[[ -z "$title" || "$json" == "null" || "$json" == "{}" ]] && exit 0

# Normalize title (UTF-8 SAFE)
title=$(printf '%s' "$title" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

# Limit length SAFELY (characters, not bytes)
title=$(printf '%s' "$title" | awk '{print substr($0,1,50)}')

title_upper=$(printf '%s' "$title" | tr '[:lower:]' '[:upper:]')

# Icon detection (NVIM first)
if [[ "$title_upper" == *"NVIM"* || "$title_upper" == *"NEOVIM"* ]]; then
  icon=" "
else
  case "${class^^}" in
  CODE | CODE-INSIDERS) icon="󰨞 " ;;
  KITTY | ALACRITTY | FOOT) icon=" " ;;
  FIREFOX) icon=" " ;;
  DISCORD) icon="󰙯 " ;;
  *) icon=" " ;;
  esac
fi

# Output — FORCE UTF-8 CLEAN
printf '{"text":"%s","tooltip":"%s"}\n' \
  "$icon$title" "$class: $title" |
  iconv -f utf-8 -t utf-8 -c
