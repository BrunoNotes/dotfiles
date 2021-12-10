#!/bin/bash

function run {
    if ! pgrep $1 ;
    then
        $@&
    fi
}

run picom &
run nm-applet &
run pamac-tray &
nitrogen --restore &
