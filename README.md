<div align="center">

# 🌳 Sebuah Dotfile Iseng

**Dotfiles pribadi untuk setup my linux aku**

 *Bersifat experimental, jangan coba coba kalo ga mau mata rusak liat config ku* 

[![Arch Linux](https://img.shields.io/badge/Arch_Linux-%231793D1?logo=arch-linux&logoColor=white)](https://archlinux.org/)
[![Hyprland](https://img.shields.io/badge/Hyprland-%23000000?logo=linux&logoColor=white)](https://hyprland.org/)
[![Wayland](https://img.shields.io/badge/Wayland-FFBC00?logo=wayland&logoColor=black)](https://wayland.freedesktop.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![CSS](https://img.shields.io/badge/CSS-1572B6?logo=css3&logoColor=white)](https://www.w3schools.com/css/)

</div>

---

## 💬 Q&A

> 🗣️:"Ini config apa mas?"  
> "Config nguawor berapi api nyeni tenan i⁉️🔥💯, tema tergantung mood author" 

---

## 🚀 Quick Start

### Clone Repository

```bash
git clone https://github.com/Abiyyu-202/dotfilenya-takim.git ~/dotfiles
cd ~/dotfiles
```

### Install Symlinks

```bash
# Buat symlinks untuk semua config folders
ln -s $(pwd)/fastfetch ~/.config/fastfetch
ln -s $(pwd)/hypr ~/.config/hypr
ln -s $(pwd)/swaylock ~/.config/swaylock
ln -s $(pwd)/waybar ~/.config/waybar
ln -s $(pwd)/wofi ~/.config/wofi

# Copy starship config
cp $(pwd)/starship.toml ~/.config/starship.toml
```

### Install Dependencies

**Arch Linux:**
```bash
sudo pacman -S wlroots waybar wofi swaync pavucontrol hyprpaper grim \
  brightnessctl ttf-jetbrains-mono-nerd ttf-cascadia-code-nerd \
  woff2-font-awesome nautilus foot

yay -S bibata-cursor-theme wlroots-git zen-browser-bin swaylock-effects
```

**Fedora:**
```bash
sudo dnf install wlroots waybar wofi zsh pavucontrol brightnessctl foot nautilus
```

> 💡 **Catatan**: Beberapa paket di Fedora mungkin perlu dari COPR atau BUILD MANUAL. Cek dokumentasi resmi untuk detailnya.


> Intinya, di dalam situ harus ada:
> - 🪟 WM: Hyprland
> - 📊 Status Bar: Waybar
> - 🚀 Launcher: Wofi
> - 🔔 Notifier: Swaync
> - 🔐 Lock Screen: Swaylock
> - 📋 System Info: Fastfetch
> - ⭐ Shell Prompt: Starship
> - 🎨 Styling: CSS support, Font Nerd
> - 🔊 Audio: Pavucontrol
> - ☀️ Brightness: Brightnessctl
> - 💫 Terminal: Kitty
> - 📂 File Manager: Nautilus
> - 🎯 Cursor: Bibata (optional tapi recommended)

---

## 📂 Folder Structure

```
dotfilenya-takim/
│
├── 🎨 fastfetch/          # System info display config
│   ├── config.conf
│   └── ...
│
├── 🪟 hypr/               # Hyprland WM configuration
│   ├── hyprland.conf      
│   ├── hyprpaper.conf   
│   └── ...
│
├── 🔐 swaylock/           # Lock screen configuration
│   ├── config
│   └── ...
│
├── 📊 waybar/             # Status bar configuration
│   ├── config.jsonc       
│   ├── style.css          
│   └── ...
│
├── 🚀 wofi/               # Application launcher config
│   ├── config
│   ├── style.css
│   └── ...
│
├── ⭐ starship.toml       # Shell prompt configuration
└── 📖 README.md           # File ini
```

## ⚙️ Customization Tips

### Keybindings
Edit keybindings di `hypr/hyprland.conf` - semua kombinasi keyboard bisa disesuaikan sesuai preferensi (jangan tanya kenapa aku ga mau misahin)

### Color Scheme
Ubah warna di file CSS:
- `waybar/style.css` - Status bar colors
- `wofi/style.css` - Launcher colors
- `hypr/hyprland.conf` - Hyprland window decorations

---
### Fonts
Semua config sudah menggunakan **Jetbrains Mono Nerd Font**. Untuk mengganti, update di masing-masing config file.

---

## ⚠️ Peringatan

> **Experimental Zone!** ⚠️
> 
> - 🎨 Warna, layout, bahkan seluruh setup bisa berubah sewaktu-waktu, Kadang kalo nemu wallpaper bagus suka kepengen ganti ini itu
> - 📝 Config mungkin belum optimal untuk semua use case, jadi jangan harap workflow kalian cocok sama punya ku ini

---


## 📚 Useful Resources
> Trust me, kalian perlu ini karena aku ga pernah baca ini

- [Hyprland Wiki](https://wiki.hyprland.org/)
- [Waybar Documentation](https://github.com/Alexays/Waybar/wiki)
- [Wofi GitHub](https://github.com/francMA/wofi)
- [Nerd Fonts](https://www.nerdfonts.com/)

---



## 🎨 Preview

> ⚠️ **Experimental Zone!**  
> Warna, layout, bahkan seluruh setup bisa berubah sewaktu-waktu.  
> Kadang kalo nemu wallpaper bagus suka kepengen ganti ini itu

---
## 🎯 Rencana Ke Depan

**MUNGKIN** nanti bakal nambah konfigurasi buat WM lain, tapi untuk sekarang...  
> "Aku males nambah config, kreativitas ku nya setipis tisu"

---

## 💬 Penutup

Setup ini dibuat karena aku kebelet hyprland tapi ga bisa styling dll (thanks to deepseek and chatgpt)  
> “Simpel, santai, keliatan ~~niat~~ banget tuh AI-nya.” — Abiyyu-202

