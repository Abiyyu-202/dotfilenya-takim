#!/bin/bash
# Unified window title script (Hyprland + Niri + NVIM)

# Detect compositor
if command -v hyprctl >/dev/null 2>&1; then
  json=$(hyprctl -j activewindow 2>/dev/null)
  class=$(echo "$json" | jq -r '.class // ""')
  title=$(echo "$json" | jq -r '.title // ""')
elif command -v niri-msg >/dev/null 2>&1; then
  json=$(niri-msg -j focused-window 2>/dev/null)
  class=$(echo "$json" | jq -r '.app_id // ""')
  title=$(echo "$json" | jq -r '.title // ""')
else
  echo ""
  exit 0
fi

# Validation
if [[ -z "$title" || "$json" == "null" || "$json" == "{}" ]]; then
  echo ""
  exit 0
fi

# Normalize title
title=$(echo "$title" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//' | cut -c1-50)
title_upper=$(echo "$title" | tr '[:lower:]' '[:upper:]')

# Icon detection (NVIM first)
if [[ "$title_upper" == *"NVIM"* || "$title_upper" == *"NEOVIM"* ]]; then
  icon=" "
else
  case "${class^^}" in
  "CODE" | "CODE-INSIDERS") icon="󰨞 " ;;
  "KITTY" | "ALACRITTY" | "FOOT") icon=" " ;;
  "FIREFOX") icon=" " ;;
  "DISCORD") icon="󰙯 " ;;
  *) icon=" " ;;
  esac
fi

# Output
echo "{\"text\": \"$icon$title\", \"tooltip\": \"$class: $title\"}"
