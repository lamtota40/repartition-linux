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


#resize/mengecilkan partisi
parted /dev/vda ---pretend-input-tty <<EOF
resizepart 2 20GB
yes
quit
EOF

#membuat partisi baru
parted /dev/vda --script mkpart primary btrfs 20GB 100%
#refresh ulang sistem agar mengenali partisi baru
partprobe /dev/vda
#cek lsblk akan muncul partisi baru /dev/vda3

#format partisi
mkfs.btrfs -f -L dataku /dev/vda3
