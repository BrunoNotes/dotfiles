#!/bin/bash

# alias gnvim='nvim --listen /tmp/godot.pipe'

while getopts "gu" flag; do
    case $flag in
        g) # godot
            nvim --listen /tmp/godot.pipe
            ;;
        u) # unreal
            nvim --listen /tmp/unreal.pipe
            ;;
        \?) # Handle invalid options
            read -p "Pipe name: " query
            nvim --listen "/tmp/$query.pipe"
            ;;
    esac
done

# no options
if [ $OPTIND -eq 1 ]; then 
    read -p "Pipe name: " query
    nvim --listen "/tmp/$query.pipe"
fi
