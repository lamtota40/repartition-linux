lsblk
parted /dev/vda
#total 50GB,ingin membuat baru 30GB maka isi 20GB
parted /dev/vda ---pretend-input-tty <<EOF
resizepart 2 20GB
yes
30GB
yes
EOF
clear



parted /dev/vda ---pretend-input-tty <<EOF
resizepart 2 20GB
yes
quit
EOF
parted /dev/vda --script mkpart primary btrfs 20GB 100%
partprobe /dev/vda
#cek lsblk akan muncul partisi baru /dev/vda3
