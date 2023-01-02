#!/bin/bash
# 
# FILE:   tpm_installer.sh
# AUTHOR: marsh
# 
# Install tmux plugin manager called tpm to ~/.tmux/plugins/tpm
# The repo is https://github.com/tmux-plugins/tpm.
# 
# Usage:
# ./tpm_installer.sh

repo="https://github.com/tmux-plugins/tpm"
desc="$HOME/.tmux/plugins/tpm"


if ! command -v git &> /dev/null; then
  echo "git is not exist."
  exit 1
fi


if [ -d $desc ]; then
  echo "tpm is exist."
  echo "if you want to update tpm, puss prefix + U"
  echo "and after that, update tpm."

else
  echo "tpm is not exist."
  echo "install tpm"
  git clone $repo $desc

fi



# vim: sw=2 sts=2 expandtab fenc=utf-8
