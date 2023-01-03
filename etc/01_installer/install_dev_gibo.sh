#!/usr/bin/bash
# 
# NAME:   gibo_installer.sh
# AUTHOR: marsh
# 
# NOTE:
# 	install gibo from git repo.

if !(type gibo >/dev/null 2>&1); then
  echo "install gibo to ~/bin. Use ~/bin/gibo"
  curl -L https://raw.github.com/simonwhitaker/gibo/master/gibo \
      -so ~/bin/gibo && chmod +x ~/bin/gibo && gibo update
fi
