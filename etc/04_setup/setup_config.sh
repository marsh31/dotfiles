#!/bin/bash
#
# NAME:   setup_config.sh
# AUTHOR: marsh
# NOTE:
#
#    setup config dir.
#  config dir: $HOME/.config/

list=(
  "$HOME/dotfiles/config/neofetch"
  "$HOME/dotfiles/config/nvim"
)

for path in "${list[@]}"; do
  echo "ln -s ${path} $HOME/.config/"
  ln -s ${path} $HOME/.config/
done

