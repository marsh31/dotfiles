#!/bin/bash
# 
# NAME:   init_arch.sh
# AUTHOR: marsh
# NOTE:
#

# update mirror site list and update package
sudo pacman-mirrors --fasttrack && sudo pacman -Syyu


# install aur helper
sudo pacman -S yay
sudo pacman -S base base-devel

# install git
if !(type git > /dev/null 2>&1); then
  pacman -S git
fi


# change config
if !(type vim > /dev/null 2>&1); then
	pacman -S vim
fi
sudo vim /home/marsh/dotfiles/doc/compressxz.md


# font
sudo pacman -S adobe-source-han-sans-jp-fonts
~/dotfiles/etc/01_installer/install_font_noto.sh
~/dotfiles/etc/01_installer/install_font_nerd-font.sh

# gtk update
# ~/dotfiles/etc/01_installer/
sudo pacman -S xdg-user-dirs-gtk
LANG=C xdg-user-dirs-gtk-update


# IM(input method) framework
~/dotfiles/etc/01_installer/install_arch_im.sh

# Antivirus
~/dotfiles/etc/01_installer/install_arch_antivirus.sh

# Bluetooth
~/dotfiles/etc/01_installer/install_arch_bluetooth.sh

# Firewall
~/dotfiles/etc/01_installer/install_arch_firewall_ufw.sh

# Virtual machine
~/dotfiles/etc/01_installer/install_arch_virtmachine.sh

# Graphic method.
sudo pacman -S graphviz plantuml

# System Version Manager
~/dotfiles/etc/01_installer/install_dev_asdf.sh

# Web browser
sudo pacman -S firefox
yay -S google-chrome

# audio
sudo pacman -S pulseaudio pavucontrol

# dev tool (cli)
sudo pacman -S unzip
sudo pacman -S tig tmux xsel ripgrep ranger jq  \
               jre-openjdk jdk-openjdk

# tool
sudo pacman -S vlc blender conky mpv flameshot feh rofi

# dev tool (yay)
yay -S android-studio ghq

~/dotfiles/etc/01_installer/install_dev_docker.sh
~/dotfiles/etc/01_installer/install_dev_gibo.sh
~/dotfiles/etc/01_installer/install_dev_rust.sh
~/dotfiles/etc/01_installer/install_dev_st.sh
~/dotfiles/etc/01_installer/install_dev_tmux_tpm.sh


# neovim, npm, go

# vim: set ts=4 sw=4 sts=4 et
