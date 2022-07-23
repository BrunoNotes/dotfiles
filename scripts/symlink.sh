#! /bin/bash

mkdir $HOME/mnt

ln -s /mnt/* $HOME/mnt/

ln -s /mnt/arquivo/Programming $HOME/Documents/
ln -s /mnt/arquivo/Pessoal/bruno $HOME/Documents/
ln -s /mnt/arquivo/Imagens $HOME/Pictures
ln -s /mnt/arquivo/Audio/* $HOME/Music/

mkdir $HOME/.ssh
ln -s /mnt/arquivo/Pessoal/bruno/ssh/* $HOME/.ssh/


