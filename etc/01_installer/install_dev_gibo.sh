#!/usr/bin/bash
# 
# NAME:   gibo_installer.sh
# AUTHOR: marsh
# 
# NOTE:
# 	install gibo from git repo.


curl -L https://raw.github.com/simonwhitaker/gibo/master/gibo \
    -so ~/bin/gibo && chmod +x ~/bin/gibo && gibo update
