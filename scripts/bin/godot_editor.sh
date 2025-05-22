#!/bin/bash

nvim_exe="$HOME/Apps/nvim/bin/nvim"


[ -n "$1" ] && file=$1

echo "$file"

$nvim_exe --server /tmp/godot.pipe --remote-send ':e '$file'<CR>'
