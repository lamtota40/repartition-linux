parted /dev/vda --script mklabel msdos
parted /dev/vda --script mkpart primary ext4 1MiB 513MiB
parted /dev/vda --script mkpart primary btrfs 513MiB 30GB
parted /dev/vda --script mkpart primary btrfs 30GB 100%


mkfs.ext4 /dev/vda1 -L boot
mkfs.btrfs -f -L system /dev/vda2
mkfs.btrfs -f -L data /dev/vda3
