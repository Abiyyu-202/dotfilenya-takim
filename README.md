# my dotfiles lmao

Personal Linux dotfiles, Tested on Arch, Wayland-based.

## Setup

Automated setup (installs packages, creates symlinks, and sets up wallpaper picker):

```bash
git clone https://github.com/Abiyyu-202/dotfilenya-takim.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

Or symlink configs only without installing packages:

```bash
./install.sh --links-only
```

## Stack

| Component | Tool |
|-----------|------|
| WM | Hyprland / Niri |
| Bar | Waybar |
| Launcher | Wofi |
| Terminal | Ghostty / Kitty |
| Notification | SwayNC |
| Theming | Matugen (Material You) |
| Wallpaper | Quickshell (qs-wallpaper-picker) / awww / swww |
| Lock & Idle | Hyprlock / Swaylock / Hypridle |

## Dependencies (Arch)

### Official Repositories (Pacman)

```bash
sudo pacman -S hyprland waybar wofi swaync pavucontrol grim slurp brightnessctl \
  imagemagick matugen quickshell awww jq playerctl cava nautilus kitty ghostty \
  ttf-jetbrains-mono-nerd ttf-font-awesome wl-clipboard hypridle hyprlock
```

### AUR (yay)

```bash
yay -S swww swaylock-effects bibata-cursor-theme zen-browser-bin
```

## Links

- [Wallpaper Previews](wallpaper/preview.md)
- [Hyprland Wiki](https://wiki.hypr.land/)
- [Niri](https://github.com/YaLTeR/niri)
- [Nerd Fonts](https://www.nerdfonts.com/)

---

> Im still learning how to configure things you know, dont blame me if the code worse.
