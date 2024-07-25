#!/bin/bash
set -e
. functions.sh
printf_c "     Prepairing           "

sleep 3

# installing refector to test wich servers are fastest
sudo pacman -S --noconfirm --needed reflector

printf_c "     finding fastest servers be patient          "
sleep 3

# finding the fastest archlinux servers
sudo reflector --latest 40 --sort rate --save /etc/pacman.d/mirrorlist

printf_c " fastest servers  saved  "         

cat /etc/pacman.d/mirrorlist

