#!/bin/bash

SECRETS_PATH="$HOME/.secrets"
VAULT_SECRET="$SECRETS_PATH/vault.secret"

## Drive backup
ARQUIVO=(
    "Audio"
    "Bruno"
    "config_backup"
    "Design"
    "dotfiles"
    "Images"
    "Study"
    "things"
    "Video"
)
ARQUIVO3=("Code")

ARQUIVO_DRIVE="arquivo"
ARQUIVO2_DRIVE="arquivo2"
ARQUIVO3_DRIVE="arquivo3"

# dotfiles backup
rm -rf "/mnt/$ARQUIVO_DRIVE/dotfiles"
cp -r "$HOME/dotfiles" "/mnt/$ARQUIVO_DRIVE"

# apps config
rsync -av "$HOME/.var/app/org.mozilla.Thunderbird/.thunderbird" "/mnt/$ARQUIVO_DRIVE/config_backup"
rsync -av "$HOME/.var/app/org.kde.krita/config" "/mnt/$ARQUIVO_DRIVE/config_backup/krita"

# sync
if [ -d "/mnt/$ARQUIVO2_DRIVE/backup_${ARQUIVO_DRIVE}" ]; then
    mkdir "/mnt/$ARQUIVO2_DRIVE/backup_${ARQUIVO_DRIVE}"
fi

if [ -d "/mnt/$ARQUIVO2_DRIVE/backup_${ARQUIVO3_DRIVE}" ]; then
    mkdir "/mnt/$ARQUIVO2_DRIVE/backup_${ARQUIVO3_DRIVE}"
fi

for a in "${ARQUIVO[@]}"; do
    rsync -av "/mnt/$ARQUIVO_DRIVE/${a}" "/mnt/$ARQUIVO2_DRIVE/backup_${ARQUIVO_DRIVE}"
done

for a in "${ARQUIVO3[@]}"; do
    rsync -av "/mnt/$ARQUIVO3_DRIVE/${a}" "/mnt/$ARQUIVO2_DRIVE/backup_${ARQUIVO3_DRIVE}"
done

## Pass backup
PASS_PATH="$HOME/SharedConfig/passwords/BrunoPasswords.kdbx"
PASS_ANSIBLE_PATH="$HOME/dotfiles/ansible/roles/user/files/BrunoPasswords.kdbx"

if [ -f "$PASS_PATH" ] && [ -f "$VAULT_SECRET" ]; then
    cp $PASS_PATH $PASS_ANSIBLE_PATH
    ansible-vault encrypt --vault-password-file $VAULT_SECRET $PASS_ANSIBLE_PATH
fi

## Firefox bookmarks backup (about:config | browser.bookmarks.autoExportHTML)
f_profille=$(ls "$HOME/.mozilla/firefox" | grep ".bruno")
bookmark_path="$HOME/.mozilla/firefox/${f_profille}/bookmarks.html"

if [ -f "$bookmark_path" ]; then
    cp $bookmark_path "/mnt/$ARQUIVO_DRIVE/config_backup/"
fi

# Crontab backup
# crontab -l > $HOME/dotfiles/others/crontab_backup.txt

