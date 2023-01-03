#!/bin/bash
#
# NAME:   mklink.sh
# AUTHOR: marsh31

home="$HOME"
if [[ ${home: -1} != "/" ]]; then
    home="$HOME/"
fi

dotfiles_dir="$HOME/dotfiles/"
dotfiles=(
    "$HOME/dotfiles/.Xmodmap"
)


ask_yes_no() {
    while true; do
        echo -n "$* [y/n]: "
        read ANS

        case $ANS in
            [Yy]*)
                return 0
                ;;
            [Nn]*)
                return 1
                ;;
            *)
                echo -n "Please input y or n: "
                ;;
        esac
    done
}


mk_file_link() {
    link_file="${1}"
    tget_file="${link_file/$dotfiles_dir/$home}"

    if [[ -e $tget_file ]]; then
        if ask_yes_no "Do you want to overwrite $tget_file"; then
            echo "rm $tget_file"
            rm $tget_file

            echo "ln -s ${link_file} ${tget_file}"
            ln -s ${link_file} ${tget_file}
        fi
    else
        echo "ln -s ${link_file} ${tget_file}"
        ln -s ${link_file} ${tget_file}
    fi
}


mk_dir_link() {
    :
}


for target in ${dotfiles[@]}; do
    if [[ -f "$target" ]]; then
        mk_file_link $target
    fi

    if [[ -d "$target" ]]; then
        mk_dir_link $target
    fi
done

# vim: set ts=4 sw=4 sts=4 et
