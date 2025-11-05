<h1 align="center">Sebuah Dotfile Iseng</h1>

<p align="center">
  <b>Dotfiles pribadi untuk setup my linux aku</b><br>
  <i>Bersifat experimental, jangan coba coba kalo ga mau mata rusak liat config ku</i>
</p>


---

<h2>Apa aja yang harus dilakukan sebelum make ni config?</h>

## 🧩 Dependensi

Setelah clone repo ini, **jangan lupa install perintilan nya (ini aku sesuaikan dengan penggunaan ku sendiri, tapi kamu bisa atur sesuka kamu)**  
Setup ini umumnya pakai paket berikut (atau setara di distro kamu):

```bash
# Fedora (beberapa paket mungkin beda nama atau perlu COPR)
sudo dnf install wlroots waybar wofi zsh pavucontrol brightnessctl foot nautilus
  (loh kenapa dikit di fedora?, jawaban nya karena di fedora ribet, harus pake ini itu, itu yang di contoh yang avalible di dnf aja)

# Arch Linux
sudo pacman -S wlroots waybar wofi swaync pavucontrol hyprpaper grim brightnessctl ttf-jetbrains-mono-nerd ttf-cascadia-code-nerd woff2-font-awesome nautilus foot && yay -S bibata-cursor-theme wlroots-git zen-browser-bin swaylock-effects 
```

> 💡 Jika ada paket yang tidak ditemukan, cek lagi perlu repo apa atau kemungkinan buruknya **BUILD MANUAL** (god i love fedora)

Intinya, di dalam situ harus ada waybar, wofi, notifier (di config ini aku pakai swaync), pavucontrol, brightnessctl, cursor (opsional tapi menambah estetika), terminal (disini aku pakai foot), file manager, sama perlu ttf-jetbrains-mono-nerd, dan juga nambah swaylock-effect

---

## 📂 Struktur Repo

```bash
dotfilenya-takim/
├── hypr/          # config hyprland
│   ├── hyprland.conf
│   └── ...
├── waybar/        # config waybar
│   ├── config.jsonc
│   ├── style.css
│   └── ...
├── wofi/          # config launcher (Wofi)
│   ├── style.css
│   └── config
├── arch.png       # BIASANYA wallpaper
└── README.md      # file ini
```

---

## 🚧 Peringatan

> ⚠️ **Experimental Zone!**  
> Warna, layout, bahkan seluruh setup bisa berubah sewaktu-waktu.  
> Kadang kalo nemu wallpaper bagus suka kepengen ganti ini itu

---

## 🧠 Rencana Ke Depan

**MUNGKIN** nanti bakal nambah konfigurasi buat WM lain, tapi untuk sekarang...  
> “Aku males ges nambah config, kreativitas ku nya setipis tisu”

---

## 🪄 Cara Pakai

```bash
git clone https://github.com/Abiyyu-202/dotfilenya-takim.git
cd dotfilenya-takim

ln -s $(pwd)/hypr ~/.config/hypr
ln -s $(pwd)/waybar ~/.config/waybar
ln -s $(pwd)/wofi ~/.config/wofi
```

---

## 💬 Penutup

Setup ini dibuat karena owner nya pengen ngetes AI buat design ae (thanks to deepseek and chatgpt)  
> “Simpel, santai, keliatan ~~niat~~ banget tuh AI-nya.” — Abiyyu-202

