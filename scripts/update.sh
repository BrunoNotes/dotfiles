#! /bin/bash

sudo timeshift --create --comments "Before Upgrade"

sudo dnf update -y
flatpak update -y
