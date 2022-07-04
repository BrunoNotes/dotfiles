#! /bin/bash

rsync -havu "/mnt/Arquivo/Pessoal/" "/mnt/Arquivo2/backup/pessoal/"
rsync -havu "/mnt/Arquivo/Faculdade/" "/mnt/Arquivo2/backup/faculdade/"
rsync -havu "/mnt/Arquivo/Alura/" "/mnt/Arquivo2/backup/alura/"
rsync -havu "/mnt/Arquivo/imagens/" "/mnt/Arquivo2/backup/imagens/"
rsync -havu "/home/bruno/Documents/bruno/" "/mnt/Arquivo/Pessoal/bruno/"
rsync -havu "/home/bruno/.ssh/" "/mnt/Arquivo/Pessoal/bruno/ssh/"
rsync -havu "/mnt/Arquivo/Programming//" "/mnt/Arquivo2/backup/Programming/"
rsync -havu "/home/bruno/dotfiles/" "/mnt/Arquivo/Pessoal/dotfiles/"
