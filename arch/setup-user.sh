#!/bin/bash
set -Eeuo pipefail

PACKAGES=(polybar k9s-bin kubernetes-helm-bin)
AURPATH=${HOME}/code/aur

mkdir -p "${AURPATH}"

for p in "${PACKAGES[@]}"
do
	git clone "https://aur.archlinux.org/${p}.git" "${AURPATH}/${p}"
	pushd "${AURPATH}/${p}"
	makepkg -si --noconfirm
	popd
done
