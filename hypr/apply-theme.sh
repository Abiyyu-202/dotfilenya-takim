#!/usr/bin/env bash
# Apply Hyprland Dark Theme and Icon Settings

# GTK & GNOME settings
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface gtk-theme 'Breeze-Dark'
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
gsettings set org.gnome.desktop.interface cursor-theme 'Bibata-Modern-Ice'

# GTK config files
for f in "$HOME/.config/gtk-3.0/settings.ini" "$HOME/.config/gtk-4.0/settings.ini"; do
    if [ -f "$f" ]; then
        sed -i 's/^gtk-application-prefer-dark-theme=.*/gtk-application-prefer-dark-theme=true/' "$f"
        sed -i 's/^gtk-theme-name=.*/gtk-theme-name=Breeze-Dark/' "$f"
        sed -i 's/^gtk-icon-theme-name=.*/gtk-icon-theme-name=Papirus-Dark/' "$f"
        sed -i 's/^gtk-cursor-theme-name=.*/gtk-cursor-theme-name=Bibata-Modern-Ice/' "$f"
    fi
done

# Qt & KDE settings
plasma-apply-colorscheme BreezeDark >/dev/null 2>&1 || true
kwriteconfig6 --file kdeglobals --group General --key ColorScheme BreezeDark
kwriteconfig6 --file kdeglobals --group Icons --key Theme Papirus-Dark
kwriteconfig6 --file kdeglobals --group KDE --key widgetStyle Breeze
kwriteconfig6 --file kcminputrc --group Mouse --key cursorTheme Bibata-Modern-Ice
kwriteconfig6 --file kcminputrc --group Mouse --key cursorSize 24

# Kvantum
kvconfig="$HOME/.config/Kvantum/kvantum.kvconfig"
if [ -f "$kvconfig" ]; then
    sed -i 's/^theme=.*/theme=KvDark/' "$kvconfig"
fi
