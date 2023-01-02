#!/bin/bash
# NAME:   install_dev_asdf.sh
# AUTHOR: marsh
# NOTE:
#
#   `asdf` is tool version manager.
#
#
# REF:
# https://asdf-vm.com/guide/getting-started.html
#

cmd="asdf"
url="https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2"

if !(type "$cmd" >/dev/null 2>&1); then
  git clone "$url"

else
  echo "$cmd is exist."
fi

cat <<EOF

- Bash & Git
Add the following to ~/.bashrc
$ . $HOME/.asdf/asdf.sh

And Completions:
$ . $HOME/.asdf/completions/asdf.bash


- Zsh  & Git
Add the following to ~/.zshrc
$ . $HOME/.asdf/asdf.sh

Add Completions:
$ # append completions to fpath
$ fpath=(${ASDF_DIR}/completions $fpath)
$ # initialise completions with ZSH's compinit
$ autoload -Uz compinit && compinit

EOF
