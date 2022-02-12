#! /bin/bash

rsync -av "/mnt/arquivo/Pessoal/" "/mnt/arquivo2/backup/pessoal/"
rsync -av "/mnt/arquivo/Faculdade/" "/mnt/arquivo2/backup/faculdade/"
rsync -av "/mnt/arquivo/Alura/" "/mnt/arquivo2/backup/alura/"
rsync -av "/mnt/arquivo/imagens/" "/mnt/arquivo2/backup/imagens/"
rsync -av "/home/bruno/Documents/bruno/" "/mnt/arquivo/Pessoal/bruno"
