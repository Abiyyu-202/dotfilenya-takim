<h1 align="center">Sebuah Dotfile iseng</h1>

<p align="center">
  <b>Dotfiles pribadi untuk setup my linux aku</b><br>
  <i>Bersifat experimental, jangan coba coba kalo ga mau mata rusak liat config ku</i>
</p>


---

<p>Apa aja yang harus dilakukan sebelum make ni config?</p>

---

## 🧩 Dependensi

Setelah clone repo ini, **jangan lupa install dependensinya dulu!**  
Setup ini umumnya pakai paket berikut (atau setara di distro kamu):

```bash
# Fedora (beberapa paket mungkin beda nama atau perlu COPR)
sudo dnf install wlroots waybar wofi zsh pavucontrol brightnessctl kitty nautilus \
  && echo "Periksa juga: swww, swaync, bibata-cursor-theme, JetBrains Mono, Cascadia Code"

# Arch Linux
sudo pacman -S wlroots zsh waybar wofi swaync pavucontrol swww grim brightnessctl \
  ttf-jetbrains-mono-nerd ttf-cascadia-code-nerd bibata-cursor-theme nautilus kitty
```

> 💡 Jika ada paket yang tidak ditemukan, coba cari dengan:
> ```bash
> dnf search <nama_paket>
> ```
> atau gunakan **COPR** / build manual.

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

MUNGKIN nanti bakal nambah konfigurasi buat **WM lain**, tapi untuk sekarang...  
> “Aku males ges nambah config, kreativitas owner nya setipis tisu”

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

