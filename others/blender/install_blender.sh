#!/bin/sh

# the site doesnt allow automatic download
read -p "Blender zip path: " blender_path_q
# echo $blender_path_q

destination_dir="$HOME/Documents/apps"
bin_folder="$HOME/.local/bin"
app_name="blender"

zip_file=$(basename "$blender_path_q")
remove_ext="${zip_file%.*}"
file_name="${remove_ext%.*}"
# file_name="${fn_temp%%-*}"
app_folder="$destination_dir/$app_name"
exists=0

echo $app_name
# echo $app_folder

install_app () {
    if [ ! -d "$app_folder" ]; then
        mkdir "$app_folder"
    fi

    # unzip "$blender_path_q" -d "$app_folder"
    tar xf "$blender_path_q" --directory="$app_folder"

    ln -s "$app_folder/$file_name/$app_name" "$bin_folder/$app_name"

    cp "$HOME/dotfiles/others/$app_name/$app_name.desktop" "$HOME/.local/share/applications/"
    echo "Exec=$app_folder/$file_name/$app_name" >> "$HOME/.local/share/applications/$app_name.desktop"
}

if [ -d "$app_folder" ]; then
    echo "$app_folder exists"
    exists=1
    while getopts "ut" flag; do
    case $flag in
        u) # -a update all
            rm -rf $app_folder
            rm -rf "$bin_folder/$app_name"

            install_app
        ;;
        t) # test
            cp "$HOME/dotfiles/others/$app_name/$app_name.desktop" "$HOME/.local/share/applications/"
            echo "Exec=$app_folder/$file_name/$app_name" >> "$HOME/.local/share/applications/$app_name.desktop"
        ;;
        \?) # Handle invalid options
            echo "Invalid Option"
        ;;
    esac
done
else
    echo "$app_folder dont exists"
    exists=0

    install_app
fi

