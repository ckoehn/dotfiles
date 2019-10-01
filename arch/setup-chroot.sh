#!/bin/bash
# Parameters: <USERNAME> <PASSWORD>
set -Eeuo pipefail

USERNAME=$1
PASSWORD=$2

# Install all packages
grep -v '#' packages.txt | tr ' ' '\n' | pacman -S --needed --noconfirm -

# LightDM autologin
groupadd -r autologin
gpasswd -a ${USERNAME} autologin
sed -i "s/^#\(autologin-user=\)$/\1${USERNAME}/" /etc/lightdm/lightdm.conf

# Docker without sudo
gpasswd -a ${USERNAME} docker

systemctl enable NetworkManager lightdm
