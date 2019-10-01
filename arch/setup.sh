#!/bin/bash
set -Eeuo pipefail

trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

MIRRORLIST_URL="https://www.archlinux.org/mirrorlist/?country=DE&protocol=https&use_mirror_status=on"

function chroot {
	arch-chroot /mnt "$@"
}


#
# SETUP
#
ping -c 1 google.com || ( echo "No internet connection! Use wifi-menu?"; exit 1; )
timedatectl set-ntp true
timedatectl status
loadkeys de-latin1

# Install rankmirrors
pacman -Sy --noconfirm pacman-contrib


#
# INPUT
#
HOSTNAME=$(dialog --stdout --inputbox "Enter hostname" 0 0 "mufflon") || exit 1
clear
: "${HOSTNAME:?"Please specify a value!"}"

USERNAME=$(dialog --stdout --inputbox "Enter username" 0 0 "ckoehn") || exit 1
clear
: "${USERNAME:?"Please specify a value!"}"

USER_PASSWORD=$(dialog --stdout --insecure --passwordbox "Enter password" 0 0) || exit 1
clear
: ${USER_PASSWORD:?"Please specify a value!"}
USER_PASSWORD2=$(dialog --stdout --insecure --passwordbox "Enter password again" 0 0) || exit 1
clear
[[ "$USER_PASSWORD" == "$USER_PASSWORD2" ]] || ( echo "Password mismatch"; exit 1; )

_list=$(lsblk -dplnx size -o name,size | grep -Ev "boot|rpmb|loop" | tac)
DEVICE=$(dialog --stdout --menu "Select device" 0 0 0 ${_list}) || exit 1
clear

SWAP_SIZE=$(dialog --stdout --inputbox "Enter swap size" 0 0 "8G") || exit 1
clear
: ${SWAP_SIZE:?"Please specify a value!"}

DEVICE_PASSWORD=$(dialog --stdout --insecure --passwordbox "Enter LUKS password" 0 0) || exit 1
clear
: ${DEVICE_PASSWORD:?"Please specify a value!"}
DEVICE_PASSWORD2=$(dialog --stdout --insecure --passwordbox "Enter LUKS password again" 0 0) || exit 1
clear
[[ "$DEVICE_PASSWORD" == "$DEVICE_PASSWORD2" ]] || ( echo "LUKS password mismatch"; exit 1; )

TIMEZONE=$(dialog --stdout --inputbox "Enter timezone" 0 0 "Europe/Berlin") || exit 1
clear
: ${TIMEZONE:?"Please specify a value!"}

echo HOSTNAME :: ${HOSTNAME}
echo USERNAME :: ${USERNAME}
echo DEVICE :: ${DEVICE}
echo SWAP_SIZE :: ${SWAP_SIZE}
echo TIMEZONE :: ${TIMEZONE}


#
# DISK LAYOUT
#
sgdisk -Z ${DEVICE}
sgdisk -n 1:0:+200M -t 0:ef00 ${DEVICE} # /boot/efi
sgdisk -n 2:0:+1G -t 0:8300 ${DEVICE}   # /boot
sgdisk -n 3:0:0 -t 0:8300 ${DEVICE}     # /
partprobe ${DEVICE}

# Match /dev/sdaX AND /dev/nvme0n1pX
EFI_PARTITION="$(ls ${DEVICE}* | grep -E "^${DEVICE}p?1$")"
BOOT_PARTITION="$(ls ${DEVICE}* | grep -E "^${DEVICE}p?2$")"
ROOT_PARTITION="$(ls ${DEVICE}* | grep -E "^${DEVICE}p?3$")"

sgdisk -p ${DEVICE}

echo EFI :: ${EFI_PARTITION}
echo BOOT :: ${BOOT_PARTITION}
echo ROOT :: ${ROOT_PARTITION}

# https://wiki.archlinux.org/index.php/Dm-crypt/Encrypting_an_entire_system#LVM_on_LUKS
echo -n ${DEVICE_PASSWORD} | cryptsetup luksFormat --type luks2 ${ROOT_PARTITION} -
echo -n ${DEVICE_PASSWORD} | cryptsetup open ${ROOT_PARTITION} luks -

pvcreate /dev/mapper/luks
vgcreate arch /dev/mapper/luks

lvcreate -L ${SWAP_SIZE} arch -n swap
lvcreate -l 100%FREE arch -n root

mkswap /dev/arch/swap
mkfs.ext4 /dev/arch/root
mkfs.ext4 ${BOOT_PARTITION}
mkfs.fat -F32 ${EFI_PARTITION}

mount /dev/arch/root /mnt
mkdir /mnt/boot
mount ${BOOT_PARTITION} /mnt/boot
mkdir /mnt/boot/efi
mount ${EFI_PARTITION} /mnt/boot/efi
swapon /dev/arch/swap


#
# SETUP
#
curl -sL "${MIRRORLIST_URL}" | \
	sed -e 's/^#Server/Server/' -e '/^#/d' | \
	rankmirrors -n 5 - > /etc/pacman.d/mirrorlist

pacstrap /mnt base base-devel intel-ucode grub efibootmgr vim zsh git

genfstab -U /mnt >> /mnt/etc/fstab

chroot ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime
chroot hwclock --systohc

echo ${HOSTNAME} > /mnt/etc/hostname

cat <<EOF > /mnt/etc/hosts
127.0.0.1	localhost
::1		localhost
127.0.1.1	${HOSTNAME}
EOF

echo 'KEYMAP=de-latin1' > /mnt/etc/vconsole.conf

cat <<EOF > /mnt/etc/locale.gen
de_DE.UTF-8 UTF-8
en_US.UTF-8 UTF-8
EOF

cat <<EOF > /mnt/etc/locale.conf
LANG=en_US.UTF-8
LC_ADDRESS=de_DE.UTF-8
LC_IDENTIFICATION=de_DE.UTF-8
LC_MEASUREMENT=de_DE.UTF-8
LC_MONETARY=de_DE.UTF-8
LC_NAME=de_DE.UTF-8
LC_NUMERIC=de_DE.UTF-8
LC_PAPER=de_DE.UTF-8
LC_TELEPHONE=de_DE.UTF-8
LC_TIME=de_DE.UTF-8
EOF

chroot locale-gen

# https://wiki.archlinux.org/index.php/Dm-crypt/Encrypting_an_entire_system#LVM_on_LUKS
# https://wiki.archlinux.org/index.php/Dm-crypt/System_configuration
chroot sed -i 's/HOOKS=(base udev autodetect modconf block filesystems keyboard fsck)/HOOKS=(base udev autodetect keyboard keymap modconf block encrypt lvm2 filesystems fsck)/g' /etc/mkinitcpio.conf
chroot mkinitcpio -p linux
chroot grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=grub

ROOT_UUID=$(blkid -s UUID -o value ${ROOT_PARTITION})
chroot sed -i "s/GRUB_CMDLINE_LINUX=\"\"/GRUB_CMDLINE_LINUX=\"cryptdevice=UUID=${ROOT_UUID}:luks\"/g" /etc/default/grub
chroot grub-mkconfig -o /boot/grub/grub.cfg

echo '%wheel ALL=(ALL) ALL' > /mnt/etc/sudoers.d/wheel

chroot useradd -m -G wheel -s /usr/bin/zsh ${USERNAME}
echo "${USERNAME}:${USER_PASSWORD}" | chpasswd --root /mnt

# Disable root login
passwd --root /mnt -l root

cp setup-chroot.sh packages.txt /mnt
chroot ./setup-chroot.sh ${USERNAME} ${USER_PASSWORD}

echo -e '\nDone'
