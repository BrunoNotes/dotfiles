#!/bin/sh

# ln -s $HOME/dotfiles/others/godot/godot4 $HOME/.local/bin/godot4
# ln -s $HOME/dotfiles/others/godot/Godot.desktop $HOME/.local/share/applications/Godot.desktop
# cp $HOME/dotfiles/others/godot/Godot.desktop $HOME/.local/share/applications/
#
# ln -s $HOME/dotfiles/others/godot/godot.sh $HOME/.local/bin

get_latest_release() {
    curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
        grep 'tag_name' |                                           # Get tag line
        sed -E 's/.*"([^"]+)".*/\1/'                                   # Pluck JSON value
}

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
REPO="godotengine/godot"
APP_VERSION=$(get_latest_release $REPO)
download_link="https://github.com/godotengine/godot/releases/download/$APP_VERSION/Godot_v${APP_VERSION}_mono_linux_x86_64.zip"
echo $APP_VERSION
echo $download_link

temp_dir="/tmp"
destination_dir="$HOME/Documents/apps"
bin_folder="$HOME/.local/bin"

zip_file=$(basename "$download_link")
fn_temp="${zip_file%%.*}"
file_name="${fn_temp%%_*}"
app_folder="$destination_dir/$file_name"
exists=0

echo $zip_file

download_app () {
    if [ ! -f "$temp_dir/$zip_file" ] && [ exists=0 ]; then
        # echo "$temp_arquive dont exists"
        wget $download_link --directory-prefix=$temp_dir
    fi
}

install_app () {
    if [ ! -d "$app_folder" ]; then
        mkdir "$app_folder"
    fi

    unzip "$temp_dir/$zip_file" -d "$app_folder"
    ln -s "$SCRIPT_DIR/godot" "$bin_folder/godot"
}

if [ -d "$app_folder" ]; then
    echo "$app_folder exists"
    exists=1
    while getopts "u" flag; do
    case $flag in
        u) # -a update all
            rm -rf $app_folder
            rm -rf "$bin_folder/$file_name"
            download_app
            install_app
            cp "$SCRIPT_DIR/Godot.desktop" "$HOME/.local/share/applications/"
        ;;
        \?) # Handle invalid options
            echo "Invalid Option"
        ;;
    esac
done
else
    echo "$app_folder dont exists"
    exists=0

    download_app
    install_app
fi

if [ ! -f "$HOME/.local/share/applications/Godot.desktop" ]; then
    cp "$SCRIPT_DIR/Godot.desktop" "$HOME/.local/share/applications/"
fi
