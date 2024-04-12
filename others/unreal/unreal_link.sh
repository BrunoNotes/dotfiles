#!/bin/bash

# Download the linux build and bridge from the epic website (backup in arquivo/config_backup/unreal)
# Copy the contents of the bridge to the engine folder of the linux build
# Put the linux build inside the Documents/Apps/UnrealEngine
# Download epic game store from lutris
# Then run this script

user=$(whoami)
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

cp $SCRIPT_DIR/Unreal.desktop $HOME/.local/share/applications/Unreal.desktop

ln -s $HOME/Code/Unreal\ Projects $HOME/Games/epic-games-store/drive_c/users/${user}/Documents
ln -s $HOME/Code/Unreal\ Projects $HOME/Documents

ln -s "$SCRIPT_DIR/unreal" "$HOME/.local/bin"
