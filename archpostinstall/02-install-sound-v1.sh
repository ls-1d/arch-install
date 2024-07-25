#!/bin/bash
set -e
. functions.sh

#Sound
sudo pacman -S pulseaudio pulseaudio-alsa pavucontrol  --noconfirm --needed
sudo pacman -S alsa-utils alsa-plugins alsa-lib alsa-firmware --noconfirm --needed

printf_c  "#########   sound software software installed   ################"

