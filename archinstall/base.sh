#!/bin/bash

echo "-------------------------------------------------"
echo "     BASE SYSTEM INSTALLATION SCRIPT              "
echo "-------------------------------------------------"

loadkeys us
timedatectl set-ntp true

echo "-------------------------------------------------"
echo "      Formatting Drive"
echo "-------------------------------------------------"
echo "      boot/swap/root/home                         "
echo "-------------------------------------------------"
sleep 3

mkfs.fat -F32 /dev/sda1	
mkswap /dev/sda2
swapon /dev/sda2
mkfs.ext4 /dev/sda3
mkfs.ext4 /dev/sda4

echo "-------------------------------------------------"
echo "     Mounting Drive                               "
echo "-------------------------------------------------"
sleep 3

mount /dev/sda3 /mnt
mkdir /mnt/{boot,home}
mount /dev/sda1 /mnt/boot
mount /dev/sda4 /mnt/home

echo "-------------------------------------------------"
echo "    Installing Base System                        "
echo "-------------------------------------------------"
sleep 3

basepkgs="base base-devel linux linux-firmware vim intel-ucode"

while ! pacstrap /mnt ${basepkgs}; do
  sleep 10
done

pacstrap -U /mnt ${basepkgs}
clear

echo "-------------------------------------------------"
echo "    Generating fstab"
echo "-------------------------------------------------"
sleep 3

genfstab -U /mnt >> /mnt/etc/fstab

cp base2.sh /mnt
cp base.sh /mnt

echo "-------------------------------------------------"
echo "    Proceeding installation"
echo "-------------------------------------------------"
sleep 3

chmod +x /mnt/base2.sh
arch-chroot /mnt /bin/bash -c ./base2.sh

# continuation on base2.sh #
