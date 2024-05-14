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

script_path="$HOME/dotfiles/ansible/roles/apps/files"

while getopts "ab" flag; do
    case $flag in
        a) # -a update all
            /bin/bash $script_path/nvim_install.sh -u
            /bin/bash $script_path/lazygit_install.sh -u
        ;;
        b) # -b
            echo "Not Implemented"
        ;;
        \?) # Handle invalid options
            echo "Invalid Option"
        ;;
    esac
done

