parted /dev/vda --script mklabel msdos
parted /dev/vda --script mkpart primary ext4 1MiB 513MiB
parted /dev/vda --script mkpart primary btrfs 513MiB 30GB
parted /dev/vda --script mkpart primary btrfs 30GB 100%
