#!/bin/bash

xmodmap_file="$HOME/dotfiles/.Xmodmap"

if [[ ! -e $xmodmap_file ]]; then
	ln -s $xmodmap_file $HOME
fi

xmodmap $HOME/.Xmodmap

cat<<'EOF'
If you want to change keymap, you should use xev.
You can know the keycode using xev. So, You can 
change .Xmodmap.

EOF
