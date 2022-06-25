#! /bin/bash

sudo timeshift --create --comments "Before Upgrade"

sudo pacman -Syu --noconfirm
paru -Syu --noconfirm
flatpak update -y
