#!/bin/sh
ICON_PATH="/home/bruno/Pictures/Images/icons/blender.svg"
TEMP_DIR="/tmp"
APPS_DIR="$HOME/Apps"
BIN_DIR="$HOME/.local/bin"

read -p "APP zip path: " app_path_q

zip_file_name=$(basename $app_path_q)
fn_temp="${zip_file_name%%.*}"
file_name="${fn_temp%%-*}" # change _ to - depending on the zip file name
file_extension="${zip_file_name##*.}"
app_folder="$APPS_DIR/$file_name"

install_app () {
    if [ ! -d "$app_folder" ]; then
        mkdir "$app_folder"
    fi

    if [ "$file_extension" == "zip" ]; then
        unzip "$app_path_q" -d "$app_folder"
    elif [ "$file_extension" == "xz" ]; then
        tar xf $app_path_q --directory=$app_folder
    fi

    program_folder=$(ls -d "$app_folder/"*)
    # program_executable=$(find "$program_folder" -maxdepth 1 -executable -type f)
    program_executable="${program_folder[0]}/$file_name"

    if [ -f "$BIN_DIR/$file_name" ]; then
        if [ "$BIN_DIR/$file_name" != "$BIN_DIR" ]; then
            rm -rf "$BIN_DIR/$file_name"
        fi
    fi
    ln -s "$program_executable" "$BIN_DIR/$file_name"
}

desktop_entry () {
    echo "Install desktop file?"
    read -p "y/n: " install_desktop_file

    if [ "$install_desktop_file" == "y" ]; then
        program_folder=$(ls -d "$app_folder/"*)
        # program_executable=$(find "$program_folder" -maxdepth 1 -executable -type f)
        program_executable="${program_folder[0]}/$file_name"

        desktop_file=(
            "Type=Application"
            "Name=$file_name"
            "Comment=$file_name"
            "Icon=$ICON_PATH"
            "Terminal=false"
            "Categories=Game;Code"
            "Exec=$program_executable"
        )

        if [ -f "$TEMP_DIR/$file_name.desktop" ]; then
            rm -rf "$TEMP_DIR/$file_name.desktop"
        fi

        touch "$TEMP_DIR/$file_name.desktop"

        echo "[Desktop Entry]" >> "$TEMP_DIR/${file_name}.desktop"

        for d in ${desktop_file[@]}; do
            echo $d >> "$TEMP_DIR/${file_name}.desktop"
        done

        if [ -f "$TEMP_DIR/$file_name.desktop" ]; then
            cp "$TEMP_DIR/${file_name}.desktop" "$HOME/.local/share/applications/"
        fi
    fi
}

delete_app () {
    rm -rf "$HOME/.local/share/applications/${file_name}.desktop"
    if [ "$BIN_DIR/$file_name" != "$BIN_DIR" ]; then
        rm -rf "$BIN_DIR/$file_name"
    fi
    if [ "$app_folder" != "$APPS_DIR" ]; then
        rm -rf $app_folder
    fi
}

final_message () {
    if [ -d "$app_folder" ]; then
        echo "${file_name} Installed"
    else
        echo "${file_name} Uninstalled"
    fi
}

while getopts "iutx" flag; do
    case $flag in
        i) # -i install
            install_app
            desktop_entry
            final_message
            ;;
        u) # -a update all
            delete_app
            install_app
            desktop_entry
            final_message
            ;;
        x) # -x delete
            delete_app
            final_message
            ;;
        t) # test
            echo "Test"
            # program_folder=$(find "$app_folder" -maxdepth 1 -type d)
            program_folder=$(ls -d "$app_folder/"*)
            program_executable="${program_folder[0]}/$file_name"
            echo $program_executable
            ;;
        \?) # Handle invalid options
            echo "Invalid Option"
            ;;
    esac
done
