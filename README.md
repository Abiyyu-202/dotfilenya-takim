<div align="center">

# Sebuah Dotfile Iseng

Dotfiles pribadi untuk setup Linux harian.  
Opinionated, berbasis Wayland, dan tidak ditujukan sebagai konfigurasi universal.

[![Arch Linux](https://img.shields.io/badge/Arch_Linux-%231793D1?logo=arch-linux&logoColor=white)](https://archlinux.org/)
[![Hyprland](https://img.shields.io/badge/Hyprland-%23000000?logo=linux&logoColor=white)](https://hyprland.org/)
[![Niri](https://img.shields.io/badge/Niri-8B5CF6?logo=linux&logoColor=white)](https://yalter.github.io/niri/)
[![Wayland](https://img.shields.io/badge/Wayland-FFBC00?logo=wayland&logoColor=black)](https://wayland.freedesktop.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

</div>

---

## Tentang Repo Ini

Repository ini berisi dotfiles yang digunakan untuk setup Linux sehari-hari.  
Konfigurasi dibuat berdasarkan preferensi pribadi dan dapat berubah sewaktu-waktu.

Setup ini tidak dijamin cocok untuk workflow orang lain dan sebaiknya digunakan sebagai referensi, bukan solusi siap pakai.

---

## Quick Start

### Clone Repository

```bash
git clone https://github.com/Abiyyu-202/dotfilenya-takim.git ~/dotfiles
cd ~/dotfiles
````

### Pasang Symlink

```bash
ln -s $(pwd)/fastfetch ~/.config/fastfetch
ln -s $(pwd)/hypr ~/.config/hypr
ln -s $(pwd)/swaylock ~/.config/swaylock
ln -s $(pwd)/waybar ~/.config/waybar
ln -s $(pwd)/wofi ~/.config/wofi
ln -s $(pwd)/niri ~/.config/niri

cp $(pwd)/starship.toml ~/.config/starship.toml
```

---

## Dependencies

### Arch Linux

```bash
sudo pacman -S wlroots waybar wofi swaync pavucontrol swww grim \
  brightnessctl ttf-jetbrains-mono-nerd ttf-cascadia-code-nerd \
  woff2-font-awesome nautilus foot

yay -S bibata-cursor-theme wlroots-git zen-browser-bin swaylock-effects
```

### Fedora

```bash
sudo dnf install wlroots waybar wofi zsh pavucontrol \
  brightnessctl foot nautilus
```
> 💡 **Catatan**: Itu hanya app yang bisa diinstall dari repo resmi, beberapa paket di Fedora mungkin perlu dari COPR atau BUILD MANUAL. Cek dokumentasi resmi untuk detailnya.

---

## Komponen

* Window Manager: Hyprland, Niri
* Status Bar: Waybar
* Launcher: Wofi
* Notification: Swaync
* Lock Screen: Swaylock
* System Info: Fastfetch
* Shell Prompt: Starship
* Audio Control: Pavucontrol
* Brightness: Brightnessctl
* Terminal: Kitty
* File Manager: Nautilus
* Cursor: Bibata

---

## Catatan

* Konfigurasi bersifat eksperimental
* Perubahan dapat terjadi tanpa pemberitahuan
* Tidak dioptimalkan untuk semua use case

---

## Referensi

* Hyprland Wiki — [LINK](https://wiki.hypr.land/)
* Nerd Fonts — [LINK](https://www.nerdfonts.com/)
* Niri Wiki — [LINK](https://www.nerdfonts.com/)

---

## Rencana

* Perbaikan dan penyesuaian Waybar
* Peningkatan konsistensi konfigurasi
* Fokus pada kenyamanan penggunaan

```
```
