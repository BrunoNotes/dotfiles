#!/bin/bash

new="New-Session"
sessions=(
"Code/*/*"
"Code/*"
"Code"
"dotfiles"
"dotfiles/*"
"dotfiles/*/*"
"dotfiles/*/.*"
"dotfiles/*/.*/*"
"dotfiles/*/.*/.*"
"dotfiles/*/*/*"
"SharedConfig/notes"
)

n=1
paths=()

for s in ${sessions[@]}; do
    paths+=($(ls -d $HOME/${s}/))
done

paths+=($new)

selected=$(printf '%s\n' "${paths[@]}" | fzf)
session_name=$(basename $selected)


if ["$selected" == "$new"]; then
    read -p "Session Name: " query
    current_dir=$PWD

    tmux new-session -s "$query" -d -c "$current_dir"
    tmux switch-client -t "$query"
else
    tmux new-session -s "$session_name" -d -c "$selected"
    tmux switch-client -t "$session_name"
fi


