#! /bin/bash

rsync -av "/home/bruno/Documents/joplin/" "/mnt/arquivo/Pessoal/joplin/"
rsync -av "/home/bruno/Documents/senhas/" "/mnt/arquivo/Pessoal/Senhas/"
rsync -av "/mnt/arquivo/Pessoal/" "/mnt/arquivo2/backup/pessoal/"
rsync -av "/mnt/arquivo/Faculdade/" "/mnt/arquivo2/backup/faculdade/"
rsync -av "/mnt/arquivo/Alura/" "/mnt/arquivo2/backup/alura/"
rsync -av "/mnt/arquivo/imagens/" "/mnt/arquivo2/backup/imagens/"
