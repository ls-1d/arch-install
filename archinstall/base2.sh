#!/bin/bash

echo "-------------------------------------------------"
echo " Configuring: Timezone | Locale | Host | Hostname"
echo "-------------------------------------------------"
sleep 3

# Timezone | Locale | Host | Hostname #

ln -sf /usr/share/zoneinfo/Asia/Kathmandu /etc/localtime
hwclock --systohc

echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf

read -p "Enter hostname: " hostname
echo $hostname >> /etc/hostname

cat > /etc/hosts << EOF
127.0.0.1 localhost
::1 localhost
127.0.1.1 $hostname.localdomain  $hostname
EOF


echo "-------------------------------------------------"
echo "     Setting systemd Bootloader"
echo "-------------------------------------------------"
sleep 3

bootctl --path=/boot install

cat > /boot/loader/loader.conf << EOF
timeout 4
console-mode max
default arch.conf
EOF

###
#
#
UUID="$(lsblk -dno UUID /dev/sda3)"

cat > /boot/loader/entries/arch.conf << EOF
title        Arch Linux
linux        /vmlinuz-linux
initrd       /intel-ucode.img
initrd       /initramfs-linux.img
options      root=UUID=$UUID rw
EOF

cat > /boot/loader/entries/arch-fallback.conf << EOF
title        Arch Linux (fallback initramfs)
linux        /vmlinuz-linux
initrd       /intel-ucode.img
initrd       /initramfs-linux-fallback.img
options      root="LABEL=arch" rw
EOF

echo "-------------------------------------------------"
echo "    Setting User Account"
echo "-------------------------------------------------"
sleep 3

# root User password # password is "password"
echo root:password | chpasswd

# User Password Setup #
read -p "Enter username: " user
useradd -m $user
read -p "Enter password: " pass
echo $user:$pass | chpasswd
usermod -aG wheel $user
clear

echo "-------------------------------------------------"
echo "     Installing Wireless Network Pkgs"
echo "-------------------------------------------------"
sleep 3

addpkgss="iwd dhcpcd networkmanager"

while ! pacman -Syuw --noconfirm ${addpkgss}; do
  sleep 10
done
pacman -Su --noconfirm ${addpkgss}


echo "-------------------------------------------------"
echo "     Enabling Wireless Connection"
echo "-------------------------------------------------"
sleep 3
pacman -S sudo
systemctl enable iwd
systemctl enable dhcpcd
# systemctl enable NetworkManager
clear

## End ##
echo "-------------------------------------------------------------------"
echo " Base System Installation Finished"
echo " Exit, umount -a & reboot"
echo "-------------------------------------------------------------------"
sleep 3
