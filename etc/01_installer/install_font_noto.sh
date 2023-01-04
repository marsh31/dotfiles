#!/bin/bash
#
# NAME:   install_font_noto.sh
# AUTHOR: marsh
# NOTE:
#   install noto font in arch env.

fonts=(
  "noto-fonts"
  "noto-fonts-cjk"
  "noto-fonts-emoji"
  "noto-fonts-extra"
)

install_font_list() {
  list_str=""

  for font_item in "${fonts[@]}"; do
    res=$(pacman -Qs "${font_item}")

    if [[ -z "$res" ]]; then
      list_str="${list_str} ${font_item}"
    fi
  done

  # sudo pacman -S noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra
  echo "$list_str"
}

list_str=$(install_font_list)
sudo pacman -S $list_str
