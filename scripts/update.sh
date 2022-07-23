#! /bin/bash

sudo timeshift --create --comments "Before Upgrade"

sudo pacman -Syu --noconfirm
sudo paru -Syu --noconfirm
flatpak update -y
