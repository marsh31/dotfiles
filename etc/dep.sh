#!/usr/bin/bash
# NAME:   dep.sh
# AUTHOR: marsh
# NOTE:
#   ./dep.sh <dep_data_file>
#   In <dep_data_file>, written a data of white list linked files or dirs name.
#   The data like below.
# ```txt
# .bashrc
# .profile
# .config/alacritty
# ...data...
# ```
#   Now, not allow empty line.

## CONFIG:
DOTFILES="$HOME/dotfiles"


## link_dot
# args:
#   1 : config file path.
#   2 : 
#
# return :
#   none
link_dot() {
  ## dir
  if [[ -d ${DOTFILES}/${1} ]]; then
    dir_path=${DOTFILES}/${1}
    if [[ -d ${HOME}/${1} ]]; then
      echo "${HOME}/${1} exist. Not make link."

    else
      echo "ln -s ${DOTFILES}/${1} ${HOME}/${1}"
      ln -s ${DOTFILES}/${1} ${HOME}/${1}
    fi

  ## file
  elif [[ -f ${DOTFILES}/${1} ]]; then
    file_path=${DOTFILES}/${1}
    if [[ -f ${HOME}/${1} ]]; then
      echo "${HOME}/${1} exist. Not make link."

    else
      echo "ln -s ${DOTFILES}/${1} ${HOME}/${1}"
      ln -s ${DOTFILES}/${1} ${HOME}/${1}
    fi
    
  ## not found
  else
    file_path=${DOTFILES}/${1}
    echo "${file_path} not found."
  fi
}


## main
# args:
#   1 :
#   2 :
#
# return :
#   none
main() {
  if [[ $# -ne 1 ]]; then
    echo "./dep.sh <dep_data_file>"
    echo "please read note in this script header."
    exit 1
  fi

  if [[ ! -f ${1} ]]; then
    echo "${1} not found."
    exit 1
  fi

  for dot in $(cat ${1}); do
    link_dot "${dot}"
  done
}


main $@
