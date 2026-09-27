#!/usr/bin/env bash
# Toggle KDE Network Management floating window

if pgrep -f "plasmawindowed org.kde.plasma.networkmanagement" >/dev/null; then
    pkill -f "plasmawindowed org.kde.plasma.networkmanagement"
else
    nohup plasmawindowed org.kde.plasma.networkmanagement >/dev/null 2>&1 &
fi
