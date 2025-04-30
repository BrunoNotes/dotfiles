#!/bin/bash

sudo timeshift --create --comments "Before Upgrade" --tags M

apt=$(command -v apt || true)
if [[ -n $apt ]]; then
    sudo apt update -y && sudo apt dist-upgrade -y
    sudo apt autoremove -y
fi

dnf=$(command -v dnf || true)
if [[ -n $dnf ]]; then
    sudo dnf update --best --allowerasing -y
    sudo dnf autoremove -y
fi

flatpak=$(command -v flatpak || true)
if [[ -n $flatpak ]]; then
    flatpak update -y
    flatpak remove --unused -y
fi

$HOME/dotfiles/pc_config/bash/backup.sh
