#!/bin/bash

sessions=(
"Code/*/*"
"Code/*"
"Code"
"dotfiles"
"dotfiles/*"
"dotfiles/*/*"
"dotfiles/*/*"
"dotfiles/*/*/*"
"dotfiles/*/*/*"
"dotfiles/*/*/*"
"SharedConfig/notes"
)

n=1
paths=()

for s in ${sessions[@]}; do
    paths+=($(ls -d $HOME/${s}/))
done

selected=$(printf '%s\n' "${paths[@]}" | fzf)

# cd $selected
length=${#selected}

if [ "$length" -gt 0 ]; then
    cd "$selected"
fi


