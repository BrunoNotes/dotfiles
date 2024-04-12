#!/bin/bash

SECRETS_PATH="$HOME/.secrets"
VAULT_SECRET="$SECRETS_PATH/vault.secret"

## Drive backup
arquivo=("Audio" "Design" "Faculdade" "Imagens" "Pessoal" "Code" "Video" "dotfiles" "config_backup")
arquivo3=("Code")

origim_drive="arquivo"
origim_drive2="arquivo3"
destination_drive="arquivo2"

rm -rf "/mnt/$origim_drive/dotfiles"
# rsync -av "$HOME/dotfiles" "/mnt/$origim_drive"
cp -r "$HOME/dotfiles" "/mnt/$origim_drive"
rsync -av "$HOME/.var/app/org.mozilla.Thunderbird/.thunderbird" "/mnt/$origim_drive/config_backup"
rsync -av "$HOME/.var/app/org.kde.krita/config" "/mnt/$origim_drive/config_backup/krita"

if [ -d "/mnt/$destination_drive/backup" ]; then
    mkdir "/mnt/$destination_drive/backup"
fi

if [ -d "/mnt/$destination_drive/backup2" ]; then
    mkdir "/mnt/$destination_drive/backup2"
fi

for a in "${arquivo[@]}"; do
    rsync -av "/mnt/$origim_drive/${a}" "/mnt/$destination_drive/backup"
done

for a in "${arquivo3[@]}"; do
    rsync -av "/mnt/$origim_drive2/${a}" "/mnt/$destination_drive/backup2"
done

## Pass backup
pass_path="$HOME/Documents/bruno/senhas/BrunoPasswords.kdbx"
pass_ansible_path="$HOME/dotfiles/ansible/roles/user/files/BrunoPasswords.kdbx"

if [ -f "$pass_path" ] && [ -f "$VAULT_SECRET" ]; then
    cp $pass_path $pass_ansible_path
    ansible-vault encrypt --vault-password-file $VAULT_SECRET $pass_ansible_path
fi

## Firefox bookmarks backup (about:config | browser.bookmarks.autoExportHTML)
f_profille=$(ls "$HOME/.mozilla/firefox" | grep ".bruno")
bookmark_path="$HOME/.mozilla/firefox/${f_profille}/bookmarks.html"

if [ -f "$bookmark_path" ]; then
    cp $bookmark_path "/mnt/arquivo/config_backup/"
fi

# Crontab backup
# crontab -l > $HOME/dotfiles/others/crontab_backup.txt

