#!/usr/bin/bash

# install fcitx4
# sudo pacman -S fcitx fcitx-im fcitx-configtool fcitx-mozc fcitx-gtk2 fcitx-gtk3 fcitx-qt5

# install fcitx5
yay -S fcitx5 fcitx5-configtool fcitx5-gtk fcitx5-qt fcitx5-mozc-ut
# fcitx5-mozc

cat<<'EOF'
> You should write below:
> 
> Output ~/.xprofile
export LANG="ja_JP.UTF-8"
export XMODIFIERS="@im=fcitx"
export XMODIFIER="@im=fcitx"
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export DefaultIMModule=fcitx


> Output ~/.i3/config
exec --no-startup-id fcitx

EOF
