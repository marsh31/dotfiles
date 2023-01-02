#!/bin/bash
#
# NAME:   install_font_noto.sh
# AUTHOR: marsh
# NOTE:
#   install noto font in arch env.

yes | sudo pacman -S noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra
