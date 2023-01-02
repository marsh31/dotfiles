#!/bin/bash


main() {
  dic="/home/marsh/.cache/dein/repos/github.com/Shougo/dein.vim/"
  if [[ -e $dic ]]; then
    echo -e "\033[32mInstalled dein.vim\033[0m"
    echo

  else 
    curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
    sh ./installer.sh ~/.cache/dein && rm -f installer.sh
  fi
}


main $@

