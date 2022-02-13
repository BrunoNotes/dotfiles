#! /bin/bash

rsync -havu "/mnt/arquivo/Pessoal/" "/mnt/arquivo2/backup/pessoal/"
rsync -havu "/mnt/arquivo/Faculdade/" "/mnt/arquivo2/backup/faculdade/"
rsync -havu "/mnt/arquivo/Alura/" "/mnt/arquivo2/backup/alura/"
rsync -havu "/mnt/arquivo/imagens/" "/mnt/arquivo2/backup/imagens/"
rsync -havu "/home/bruno/Documents/bruno/" "/mnt/arquivo/Pessoal/bruno/"
