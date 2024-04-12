#!/bin/bash

# sudo timeshift --create --comments "Before Upgrade"

# sudo paru -Syu --noconfirm

sudo dnf update --best --allowerasing -y
sudo dnf autoremove -y

# sudo apt update -y && sudo apt dist-upgrade -y
# sudo apt autoremove -y

flatpak update -y
flatpak remove --unused -y

# update all cargo global binaries
# cargo install $(cargo install --list | egrep '^[a-z0-9_-]+ v[0-9.]+:$' | cut -f1 -d' ')

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

