#!/bin/bash

temp_note="/tmp/temp.md"
notes_path="$HOME/SharedConfig/notes"
editor="nvim"

default_note () {
    if [ -d $notes_path ]; then
        nvim "$notes_path/index.md"
    else
        mkdir $notes_path
        nvim "$notes_path/index.md"
    fi
}

while getopts "t" flag; do
    case $flag in
        t) # -t temp
            nvim $temp_note
            ;;
        *)
            default_note
            ;;
        \?)
            echo "Not implemented"
            ;;
    esac
done

# no option
if [ $OPTIND -eq 1 ]; then
    default_note
fi
