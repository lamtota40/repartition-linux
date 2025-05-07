# Total 50GB,ingin membuat baru 30GB maka isi 20GB
parted /dev/vda ---pretend-input-tty <<EOF
resizepart 2 20GB
yes
quit
EOF

# Buat partisi baru dari sisa ruang (20GB - 100%)
parted /dev/vda --script mkpart primary btrfs 20GB 100%

# Refresh partisi agar dikenali sistem
partprobe /dev/vda
sleep 2

# Cek apakah partisi baru ada
[ -b /dev/vda3 ] || { echo "Partisi /dev/vda3 tidak ditemukan!"; exit 1; }

# Format ke Btrfs dengan label "dataku"
mkfs.btrfs -f -L dataku /dev/vda3

# Tampilkan info partisi
lsblk -f
