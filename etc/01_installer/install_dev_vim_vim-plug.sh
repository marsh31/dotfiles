#!/bin/bash

if [[ -f "/home/marsh/.vim/autoload/plug.vim" ]]; then
	echo "Installed vim-plug"

else 
	echo "Not installed vim-plug yet."
	echo -n "Do you want to install vim-plug [Y/n]: "

	read ANS

	case "$ANS" in
		Y)
		echo "Installing..."
		curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
		;;

		*)
		echo "Ok."
		;;
	esac

fi



