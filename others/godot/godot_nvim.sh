#!/bin/bash
# put this script in the external option in godot
[ -n "$1" ] && file=$1

pipe="/tmp/godot.pipe"

nvim --server "$pipe" --remote-send ":e $file <CR>"

# to open use nvim --listen /tmp/godot.pipe
