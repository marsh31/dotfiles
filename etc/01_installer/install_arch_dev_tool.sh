#!/bin/bash
#
# NAME:   install_arch_dev_tool.sh
# AUTHOR: marsh
# NOTE:
#
#   Install `pacman_install_items` and `yay_install_items` package.
# The script check item command is exist, and if not exist, install it.
#


############################################################
# Config
#
############################################################

# <command_name>;<package_name>(:<package_name>)*;<handler:null or func_name>
#
pacman_install_items=(
  # audio
  # "pulseaudio;pulseaudio;"
  "pavucontrol;pavucontrol;"

  # web browser
  "firefox;firefox;"

  # dev tools
  "blender;blender;"
  "conky;conky;"
  "docker;docker;handler_docker"
  "docker-compose;docker-compose;"
  "feh;feh;"
  "flameshot;flameshot;"
  "java;jre-openjdk:jdk-openjdk;"
  "jq;jq;"
  "mpv;mpv;"
  "ranger;ranger;"
  "rg;ripgrep;"
  "rofi;rofi;"
  "tig;tig;"
  "tmux;tmux;"
  "unzip;unzip;"
  "vlc;vlc;"
  "xsel;xsel;"

  # graphic
  "graphviz;graphviz;"
  "plantuml;plantuml;"
)


yay_install_items=(
  # web browser
  "google-chrome-stable;google-chrome;"

  # dev tools
  "android-studio;android-studio;"
  "man-pages-ja;man-pages-ja;"
)


############################################################
# handler
#
############################################################
handler_docker() {
  is_exist_command "docker"
  if [[ $? -eq 1 ]]; then
    echo "sudo systemctl start docker; systemctl enable docker"
    sudo systemctl start docker
    sudo systemctl enable docker
  else
    echo "docker install failed!!!"
    echo "intrupt docker setup!"
  fi
}


############################################################
# proc
#
############################################################

#
# is_exist_command
#
is_exist_command() {
  local command
  command="${1}"

  if type "${command}" >/dev/null 2>&1; then
    # found
    return 1

  else
    # not found
    return 0
  fi
}


#
# install_items
#
install_items() {
  local arr
  local item
  local sub_str=""
  local tmp
  local command_name package_name handler


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


#
# handler_items
#
handler_items() {
  local arr
  local item
  local sub_str=""
  local tmp
  local command_name package_name handler_name


  arr=(${1})
  for item in "${arr[@]}"; do
    tmp=(${item//;/ })
    command_name="${tmp[0]}"
    package_name="${tmp[1]}"
    handler_name="${tmp[2]}"

    # echo "$command_name, $package_name, ..."
    is_exist_command $command_name
    if [[ $? -eq 0 ]] && [[ -n "${handler_name}" ]]; then
      sub_str="$sub_str ${handler_name//:/ }"
    fi
  done

  echo "$sub_str"
}


#
# do_install
#
do_install() {
  local cmd data_list
  local package_list handler_list

  cmd="${1}"
  data_list="${2}"

  package_list=$(install_items "${data_list[*]}")
  handler_list=$(handler_items "${data_list[*]}")

  if [[ -n "$package_list" ]]; then
    echo "${cmd} ${package_list}"
    ${cmd} ${package_list}
  fi

  func_arr=(${handler_list})
  for func in "${func_arr[@]}"; do
    ${func}
  done
}


#
# main process
#
main() {
  do_install "sudo pacman -S" "${pacman_install_items[*]}"
  do_install "yay -S" "${yay_install_items[*]}"
}


############################################################
# main
#
############################################################

main
