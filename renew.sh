parted /dev/vda --script mklabel msdos
parted /dev/vda --script mkpart primary ext4 1MiB 513MiB
parted /dev/vda --script mkpart primary btrfs 513MiB 30GB
parted /dev/vda --script mkpart primary btrfs 30GB 100%


mkfs.ext4 /dev/vda1 -L boot
mkfs.btrfs -f -L system /dev/vda2
mkfs.btrfs -f -L data /dev/vda3

mkdir /mnt/data
mount /dev/vda3 /mnt/data
cd /mnt/data
wget http://cdimage.ubuntu.com/lubuntu/releases/18.04.6/release/lubuntu-18.04.6-alternate-amd64.iso
mkdir /mnt/iso
mount -o loop lubuntu-18.04.6-alternate-amd64.iso /mnt/iso


mkdir /mnt/boot
mount /dev/vda1 /mnt/boot
grub-install --boot-directory=/mnt/boot /dev/vda

cat > /mnt/boot/grub/grub.cfg <<EOF
set timeout=5
menuentry "Install Lubuntu 18.04 (Alternate)" {
    set isofile="/lubuntu-18.04.6-alternate-amd64.iso"
    loopback loop (hd0,3)\$isofile
    linux (loop)/install/vmlinuz iso-scan/filename=\$isofile --
    initrd (loop)/install/initrd.gz
}
EOF

#reboot

Saat instalasi, pilih manual partitioning.
Pilih /dev/vda2 sebagai root (/) dan gunakan Btrfs (installer akan mendeteksi otomatis).
Pilih /dev/vda1 sebagai /boot dan gunakan ext4.
Abaikan /dev/vda3 kalau tidak ingin digunakan sekarang.
Pilih untuk install GRUB ke MBR (/dev/vda).
