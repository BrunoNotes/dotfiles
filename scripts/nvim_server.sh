#!/bin/bash

# alias gnvim='nvim --listen /tmp/godot.pipe'

query_pipe () {
    read -p "Pipe name: " query
    nvim --listen "/tmp/$query.pipe"
}

while getopts "guh" flag; do
    case $flag in
        g) # godot
            nvim --listen /tmp/godot.pipe
            ;;
        u) # unreal
            nvim --listen /tmp/unreal.pipe
            ;;
        h) # unreal
            echo "options:"
            echo " -h help"
            echo " -g godot"
            echo " -u unreal"
            ;;
        \?) # Handle invalid options
            query_pipe
            ;;
    esac
done

# no options
if [ $OPTIND -eq 1 ]; then
    query_pipe
fi
