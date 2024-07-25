#!/bin/bash
set -e
. functions.sh

printf_c "     Installing Pacman xorg 	"
sleep 3
pkg_list="xorg-server xorg-apps xorg-xinit xorg-twm xterm xf86-video-intel"

while ! sudo pacman -Syuw --noconfirm ${pkg_list}; do
  sleep 10
done
sudo pacman -Su --noconfirm ${pkg_list}
clear
