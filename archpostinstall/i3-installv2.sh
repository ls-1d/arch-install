#!/bin/bash

. functions.sh

printf_c "Running Desktop Installation Script"

PKGS=(
    'i3-wm'
    'i3status'
    'rofi'
    'lxappearance'
    'nitrogen'
    'picom'
    'dmenu'
    'playerctl'
    'python-dbus'
    'archlinux-wallpapers'
    'dunst'
    'lightdm'
    'lightdm-gtk-greeter'
    'lightdm-gtk-greeter-settings'
    'firefox'
    'redshift'
    'rxvt-unicode'
    'telegram-desktop'
)

for PKG in "${PKGS[@]}"; do
    echo "Installing ${PKG}"
    sudo pacman -S "$PKG" --noconfirm --needed
done

printf_c "Desktop Components Installed"
