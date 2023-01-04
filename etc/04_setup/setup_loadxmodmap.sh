#!/bin/bash

xmodmap_file="$HOME/dotfiles/.Xmodmap"

if [ ! -e "~/.Xmodmap" ]; then
	echo "ln -s $xmodmap_file $HOME"
	ln -s $xmodmap_file $HOME
fi

echo "xmodmap $HOME/.Xmodmap"
xmodmap $HOME/.Xmodmap

cat<<'EOF'
If you want to change keymap, you should use xev.
You can know the keycode using xev. So, You can 
change .Xmodmap.

EOF
