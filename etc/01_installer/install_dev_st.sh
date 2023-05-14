#!/bin/bash
# 
# NAME:   install_dev_st.sh
# AUTHOR: marsh
# NOTE:
#
#   install st.
#
# ~/.Xresources
# *font:                            xxxx
# *color0:                          #002b36
# *color8:                          #657b83
# *color1:                          #dc322f
# *color9:                          #dc322f
# *color2:                          #859900
# *color10:                         #859900
# *color3:                          #b58900
# *color11:                         #b58900
# *color4:                          #268bd2
# *color12:                         #268bd2
# *color5:                          #6c71c4
# *color13:                         #6c71c4
# *color6:                          #2aa198
# *color14:                         #2aa198
# *color7:                          #93a1a1
# *color15:                         #fdf6e3
# *background:                      #cccccc
# *foreground:                      #555555
# *cursorColor:                     #e5e5e5
# termname:
# shell:
# minlatency:
# maxlatency:
# blinktimeout",
# bellvolume:
# tabspaces:
# borderpx:
# cwscale:
# chscale:
#

REPO="git://git.suckless.org/st"
REPO_NAME="st"
PATCHES=(
  https://st.suckless.org/patches/alpha/st-alpha-20220206-0.8.5.diff
  https://st.suckless.org/patches/clipboard/st-clipboard-20180309-c5ba9c0.diff
  https://st.suckless.org/patches/font2/st-font2-0.8.5.diff
  https://st.suckless.org/patches/xresources/st-xresources-20200604-9ba7ecf.diff
  https://st.suckless.org/patches/glyph_wide_support/st-glyph-wide-support-20230701-5770f2f.diff
)
CONFIG="~/dotfiles/etc/02_config/st/config.h"


# ... download ...
echo "Download $REPO..."
git clone $REPO
cd $REPO_NAME


# ... patch ...
echo "Patch..."
for file in ${PATCHES[@]}; do
  echo "wget $file"
  wget $file
  
  echo "patch -i ${file##*/}"
  patch -i ${file##*/}
done


# ... copy my config file ...
echo "Copy config..."
cp -f $CONFIG .

echo "Build and install..."
sudo make clean install



# ... Clean ...
echo "Clean"
cd ..
rm -Rf $REPO_NAME
