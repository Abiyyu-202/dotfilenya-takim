# my dotfiles lmao

Personal Linux dotfiles, Tested on Arch, Wayland-based.

## Setup

```bash
git clone https://github.com/Abiyyu-202/dotfilenya-takim.git ~/dotfiles
cd ~/dotfiles
```

Symlink whatever you want. (I just threw the repo into ~/.config lmao):

```bash
for dir in fastfetch hypr swaylock waybar wofi niri; do
  ln -sf $(pwd)/$dir ~/.config/$dir
done
cp starship.toml ~/.config/starship.toml
```

## Stack

| Component | Tool |
|-----------|------|
| WM | Hyprland / Niri |
| Bar | Waybar |
| Launcher | Wofi |
| Terminal | Kitty |
| Lock | Swaylock |

## Dependencies (Arch)

```bash
sudo pacman -S wlroots waybar wofi swaync pavucontrol swww grim brightnessctl ttf-jetbrains-mono-nerd ttf-cascadia-code-nerd  woff2-font-awesome nautilus kitty wl-clipboard

yay -S bibata-cursor-theme zen-browser-bin swaylock-effects
```

## Links

- [Hyprland Wiki](https://wiki.hypr.land/)
- [Niri](https://github.com/YaLTeR/niri)
- [Nerd Fonts](https://www.nerdfonts.com/)

---

> Im still learning how to configure things you know, dont blame me if the code worse.
