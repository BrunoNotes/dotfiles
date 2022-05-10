#! /bin/bash

sudo timeshift --create --comments "Before Upgrade"

sudo pacman -Syu --noconfirm
yay -Syu --noconfirm
flatpak update -y
