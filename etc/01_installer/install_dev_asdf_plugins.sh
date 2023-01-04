#!/bin/bash
#
# NAME:   install_dev_asdf_plugins.sh
# AUTHOR: marsh
# NOTE:
#

list=(
  "dart"
  "fzf"
  "golang"
  "jq"
  "neovim"
  "nodejs"
)


for item in "${list[@]}"; do
  asdf plugin add "${item}"
  asdf install "${item}" latest
  asdf global "${item}" latest
done



