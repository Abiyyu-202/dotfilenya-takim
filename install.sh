#!/usr/bin/env bash

set -euo pipefail

# ANSI color codes
CLR_RESET="\033[0m"
CLR_INFO="\033[1;34m"
CLR_SUCCESS="\033[1;32m"
CLR_WARN="\033[1;33m"
CLR_ERROR="\033[1;31m"

log_info() { echo -e "${CLR_INFO}[INFO]${CLR_RESET} $*"; }
log_ok() { echo -e "${CLR_SUCCESS}[OK]${CLR_RESET} $*"; }
log_warn() { echo -e "${CLR_WARN}[WARN]${CLR_RESET} $*"; }
log_error() { echo -e "${CLR_ERROR}[ERROR]${CLR_RESET} $*"; }

DOTFILES_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"

PACMAN_PKGS=(
    hyprland
    waybar
    wofi
    swaync
    pavucontrol
    grim
    slurp
    brightnessctl
    imagemagick
    matugen
    quickshell
    awww
    jq
    playerctl
    cava
    nautilus
    kitty
    ghostty
    ttf-jetbrains-mono-nerd
    ttf-font-awesome
    wl-clipboard
    hypridle
    hyprlock
)

AUR_PKGS=(
    swww
    swaylock-effects
    bibata-cursor-theme
    zen-browser-bin
)

CONFIG_DIRS=(
    fastfetch
    hypr
    kitty
    matugen
    niri
    swaylock
    swaync
    waybar
    wofi
)

check_arch() {
    if [ ! -f /etc/arch-release ] && ! command -v pacman >/dev/null 2>&1; then
        log_warn "Sistem ini sepertinya bukan Arch Linux. Lewati instalasi paket pacman."
        return 1
    fi
    return 0
}

install_packages() {
    if ! check_arch; then
        return 0
    fi

    log_info "Memperbarui database paket dan menginstal dependensi resmi (Pacman)..."
    sudo pacman -S --needed --noconfirm "${PACMAN_PKGS[@]}"
    log_ok "Paket Pacman selesai diinstal."

    # Cek AUR helper
    AUR_HELPER=""
    if command -v yay >/dev/null 2>&1; then
        AUR_HELPER="yay"
    elif command -v paru >/dev/null 2>&1; then
        AUR_HELPER="paru"
    fi

    if [ -n "$AUR_HELPER" ]; then
        log_info "Menginstal paket AUR via $AUR_HELPER..."
        "$AUR_HELPER" -S --needed --noconfirm "${AUR_PKGS[@]}" || log_warn "Beberapa paket AUR gagal diinstal. Silakan periksa manual."
        log_ok "Paket AUR selesai diinstal."
    else
        log_warn "yay atau paru tidak ditemukan. Paket AUR berikut belum terinstal:"
        echo "  ${AUR_PKGS[*]}"
        echo "  Silakan instal yay/paru lalu pasang paket di atas secara manual."
    fi
}

setup_symlinks() {
    log_info "Membuat symlink konfigurasi ke $CONFIG_DIR..."
    mkdir -p "$CONFIG_DIR"

    for dir in "${CONFIG_DIRS[@]}"; do
        src="$DOTFILES_DIR/$dir"
        dest="$CONFIG_DIR/$dir"

        if [ ! -d "$src" ]; then
            continue
        fi

        if [ -e "$dest" ] || [ -L "$dest" ]; then
            # Jika sudah symlink ke target yang sama, lewati
            if [ -L "$dest" ] && [ "$(readlink -f "$dest")" = "$(readlink -f "$src")" ]; then
                log_ok "Symlink $dir sudah mengarah ke dotfiles (lewati)."
                continue
            fi

            backup="${dest}.bak.$(date +%Y%m%d%H%M%S)"
            log_warn "Ditemukan konfigurasi lama di $dest, dipindahkan ke $backup"
            mv "$dest" "$backup"
        fi

        ln -s "$src" "$dest"
        log_ok "Symlink dibuat: $dest -> $src"
    done

    # Starship prompt
    if [ -f "$DOTFILES_DIR/starship.toml" ]; then
        if [ -e "$CONFIG_DIR/starship.toml" ] && [ ! -L "$CONFIG_DIR/starship.toml" ]; then
            mv "$CONFIG_DIR/starship.toml" "$CONFIG_DIR/starship.toml.bak.$(date +%Y%m%d%H%M%S)"
        fi
        ln -sf "$DOTFILES_DIR/starship.toml" "$CONFIG_DIR/starship.toml"
        log_ok "Symlink dibuat: $CONFIG_DIR/starship.toml"
    fi
}

setup_wallpaper_picker() {
    target_dir="$CONFIG_DIR/qs-wallpaper-picker"
    if [ ! -d "$target_dir" ]; then
        log_info "Mengunduh qs-wallpaper-picker ke $target_dir..."
        git clone https://github.com/magetsu002/qs-wallpaper-picker.git "$target_dir"
        log_ok "qs-wallpaper-picker berhasil diunduh."
    else
        log_ok "qs-wallpaper-picker sudah ada di $target_dir."
    fi
}

fix_permissions() {
    log_info "Memastikan permission execute pada script..."
    find "$DOTFILES_DIR" -type f \( -name "*.sh" -o -name "*.py" \) -exec chmod +x {} + 2>/dev/null || true
    if [ -d "$CONFIG_DIR/qs-wallpaper-picker/scripts" ]; then
        chmod +x "$CONFIG_DIR/qs-wallpaper-picker/scripts/"*.sh 2>/dev/null || true
    fi
    log_ok "Permission execute sudah disetel."
}

main() {
    echo "========================================"
    echo "       Dotfiles Installer & Setup       "
    echo "========================================"
    echo

    SKIP_PKGS=0
    for arg in "$@"; do
        case "$arg" in
            --no-pkg|--links-only)
                SKIP_PKGS=1
                ;;
        esac
    done

    if [ "$SKIP_PKGS" -eq 0 ]; then
        read -r -p "Instal dependensi paket (Pacman & AUR)? [Y/n] " confirm || confirm="y"
        confirm="${confirm:-y}"
        if [[ "$confirm" =~ ^[Yy]$ ]]; then
            install_packages
        else
            log_info "Instalasi paket dilewati oleh pengguna."
        fi
    fi

    setup_symlinks
    setup_wallpaper_picker
    fix_permissions

    echo
    log_ok "Setup dotfiles selesai! Silakan relogin atau buka Hyprland."
}

main "$@"
