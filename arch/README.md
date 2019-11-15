# Arch setup
* UEFI
* Encrypted root/home/swap (LVM on LUKS)
* i3

## Installation
* Boot from Arch Linux ISO
* `loadkeys de-latin1`
* Check network connection: `ping -c 1 archlinux.org`. Use `wifi-menu` if necessary.
* `pacman -Sy git`
* `git clone https://github.com/ckoehn/dotfiles.git`
* `cd dotfiles/arch`
* `./setup.sh`

## Post installation
* `./setup-user.sh`
