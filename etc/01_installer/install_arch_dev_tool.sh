#!/bin/bash
#
# NAME:   install_arch_dev_tool.sh
# AUTHOR: marsh
# NOTE:
#
#   Install `pacman_install_items` and `yay_install_items` package.
# The script check item command is exist, and if not exist, install it.
#


# command_name;package_name(:package_name)*
pacman_install_items=(
  "blender;blender"
  "conky;conky"
  "feh;feh"
  "flameshot;flameshot"
  "java;jre-openjdk:jdk-openjdk"
  "jq;jq"
  "mpv;mpv"
  "ranger;ranger"
  "rg;ripgrep"
  "rofi;rofi"
  "tig;tig"
  "tmux;tmux"
  "unzip;unzip"
  "vlc;vlc"
  "xsel;xsel"
)


yay_install_items=(
  "android-studio;android-studio"
  "ghq;ghq"
)


is_exist_command() {
  local command
  command="${1}"

  if type "${command}" >/dev/null 2>&1; then
    return 1

  else
    return 0
  fi
}


install_items() {
  local arr
  local item
  local sub_str=""
  local tmp
  local command_name
  local package_name

  arr=(${1})
  for item in "${arr[@]}"; do
    tmp=(${item//;/ })
    command_name="${tmp[0]}"
    package_name="${tmp[1]}"

    # echo "$command_name, $package_name, ..."
    is_exist_command $command_name
    if [[ $? -eq 0 ]]; then
      sub_str="$sub_str ${package_name//:/ }"
    fi
  done

  echo "$sub_str"
}


do_install_pacman_items() {
  local list
  list=$(install_items "${pacman_install_items[*]}")

  if [[ -n "$list" ]]; then
    echo "sudo pacman -S $list"
    sudo pacman -S $list
  fi
}


do_install_yay_items() {
  local list
  list=$(install_items "${yay_install_items[*]}")

  if [[ -n "$list" ]]; then
    echo "yay -S $list"
    yay -S $list
  fi
}


main() {
  do_install_pacman_items
  do_install_yay_items
}


main
