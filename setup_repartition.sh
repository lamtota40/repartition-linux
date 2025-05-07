#!/bin/bash

sudo apt install grml-rescueboot zsh -y
mkdir -p /boot/grml
ARCH=$(uname -m)
if [[ "$ARCH" == "x86_64" ]]; then
    echo "Terdeteksi sistem 64-bit"
    if [ ! -f /boot/grml/grml64-small_2024.02.iso ]; then
    wget https://ftp2.osuosl.org/pub/grml/grml64-small_2024.02.iso -P /boot/grml/
    fi
    GRML_ENTRY='Grml Rescue System (grml64-small_2024.02.iso)'
elif [[ "$ARCH" == "i386" || "$ARCH" == "i686" ]]; then
    echo "Terdeteksi sistem 32-bit"
    if [ ! -f /boot/grml/grml32-small_2024.02.iso ]; then
    wget https://ftp2.osuosl.org/pub/grml/grml32-small_2024.02.iso -P /boot/grml/
    fi
    GRML_ENTRY='Grml Rescue System (grml32-small_2024.02.iso)'
else
    echo "Arsitektur tidak dikenali: $ARCH"
    GRML_ENTRY=''
    exit 1
fi
 mkdir -p /etc/grml/partconf
 sudo wget raw.githubusercontent.com/lamtota40/repartition-linux/main/autorun-grml.sh -P /etc/grml/partconf
 sudo bash -c "echo 'CUSTOM_BOOTOPTIONS=\"ssh=pas123 dns=8.8.8.8,8.8.4.4 netscript=raw.githubusercontent.com/lamtota40/repartition-linux/main/autorun-grml.sh toram\"' >> /etc/default/grml-rescueboot"
 sudo update-grub
 sudo grub-reboot "$GRML_ENTRY"
