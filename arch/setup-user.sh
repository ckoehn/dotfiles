#!/bin/bash
set -Eeuo pipefail

PACKAGES=(cfssl insomnia polybar kubernetes-helm-bin)
AURPATH=${HOME}/code/aur

mkdir -p "${AURPATH}"

for p in "${PACKAGES[@]}"
do
	git clone "https://aur.archlinux.org/${p}.git" "${AURPATH}/${p}"
	pushd "${AURPATH}/${p}"
	makepkg -si --noconfirm
	popd
done
