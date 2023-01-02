#!/usr/bin/bash
# 
# NAME:   install_font_nerd-font.sh
# AUTHOR: marsh
# 
# NOTE:
# 	install nerd fornts.
#

declare -a font_names=(
  "FiraCode"
  "Hack"
  "Mononoki"
  "ShareTechMono"
  "SourceCodePro"
)


main() {
  setup

  for name in ${font_names[@]}; do
    install "${name}"
  done

  finally
}


# download nerd-fonts repo.
setup() {
  git clone --branch=master --depth 1 https://github.com/ryanoasis/nerd-fonts.git
  cd nerd-fonts
}


# install fonts.
install() {
  ./install.sh $1
}


# remove nerd-fonts repo.
finally() {
  cd ..
  rm -rf nerd-fonts
}


main

# vim: sw=2 sts=2 expandtab fenc=utf-8
