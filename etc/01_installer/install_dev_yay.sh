#!/usr/bin/bash
# 
# NAME:   yay_installer.sh
# AUTHOR: marsh
# 
# NOTE:
# 	install yay that is package manager.
#

if !(type "yay" >/dev/null 2>&1); then
  yes | sudo pacman -S base-devel git go
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si

  cd ..
  rm -Rf yay
else
  echo "yay is installed"
fi
