#!/bin/bash

if [[ ! -e ~/.Xmodmap_default ]]; then
	xmodmap -pke > ~/.Xmodmap_default
fi


if [[ ! -e ~/.Xmodmap ]]; then
	ln -s ~/dotfiles/.Xmodmap ~/
fi

xmodmap ~/.Xmodmap
