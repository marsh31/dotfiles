#!/bin/bash
# 
# NAME:   init_arch.sh
# AUTHOR: marsh
# NOTE:
#

#
# Log function
#
echo_log() {
  echo "[init_arch]: $@"
}


#
# Main Script
#

#
# update mirror site list and update package
#
echo_log "update pacman..."
sudo pacman-mirrors --fasttrack && sudo pacman -Syyu


#
# install aur helper
#
echo_log "install yay, base, base-devel..."
yes | sudo pacman -S yay
yes | sudo pacman -S base base-devel


#
# install git
#
echo_log "checking git exist..."
if !(type git > /dev/null 2>&1); then
  echo_log "install git..."
  yes | pacman -S git
fi


#
# change config
#
echo_log "checking vim exist..."
if !(type vim > /dev/null 2>&1); then
  echo_log "install vim..."
	yes | pacman -S vim
fi
sudo vim /home/marsh/dotfiles/doc/compressxz.md


#
# font
#
echo_log "install font adobe-source-han-sans-jp-fonts, noto, nerd-font..."
yes | sudo pacman -S adobe-source-han-sans-jp-fonts
~/dotfiles/etc/01_installer/install_font_noto.sh
~/dotfiles/etc/01_installer/install_font_nerd-font.sh


#
# IM(input method) framework
#
echo_log "install IM (fcitx)"
~/dotfiles/etc/01_installer/install_arch_im.sh


#
# Antivirus
#
echo_log "install antivirus ()"
~/dotfiles/etc/01_installer/install_arch_antivirus.sh


#
# Bluetooth
#
echo_log "install bluetooth ()"
~/dotfiles/etc/01_installer/install_arch_bluetooth.sh


#
# Firewall
#
echo_log "install firewall ()"
~/dotfiles/etc/01_installer/install_arch_firewall_ufw.sh


#
# Virtual machine
#
echo_log "install virtual machine ()"
~/dotfiles/etc/01_installer/install_arch_virtmachine.sh


#
# Graphic method.
#
echo_log "install graphic method (graphviz, plantuml)"
yes | sudo pacman -S graphviz plantuml


#
# System Version Manager
#
echo_log "install system version manager (asdf)"
~/dotfiles/etc/01_installer/install_dev_asdf.sh


#
# Web browser
#
echo_log "install web browser (firefox, google-chrome)"
yes | sudo pacman -S firefox
yes | yay -S google-chrome


#
# audio
#
echo_log "install audio (pulseaudio, pavucontrol)"
yes | sudo pacman -S pulseaudio pavucontrol


#
# dev tool (cli)
#
echo_log "install dev tool (unzip)"
yes | sudo pacman -S unzip

echo_log "install dev tool (tig, tmux, xsel, ripgrep, ranger, jq, jre-openjdk, jdk-openjdk)"
yes | sudo pacman -S tig tmux xsel ripgrep ranger jq  \
               jre-openjdk jdk-openjdk

echo_log "install dev tool (vlc, blender, conky, mpv, flameshot, feh, rofi)"
yes | sudo pacman -S vlc blender conky mpv flameshot feh rofi

echo_log "install dev tool (android-studio, ghq)"
yes | yay -S android-studio ghq

~/dotfiles/etc/01_installer/install_dev_docker.sh
~/dotfiles/etc/01_installer/install_dev_gibo.sh
~/dotfiles/etc/01_installer/install_dev_rust.sh
~/dotfiles/etc/01_installer/install_dev_st.sh
~/dotfiles/etc/01_installer/install_dev_tmux_tpm.sh


# neovim, npm, go


#
# Change Local in home dir
# ~/dotfiles/etc/01_installer/
#
yes | sudo pacman -S xdg-user-dirs-gtk
LANG=C xdg-user-dirs-gtk-update

# vim: set ts=4 sw=4 sts=4 et
