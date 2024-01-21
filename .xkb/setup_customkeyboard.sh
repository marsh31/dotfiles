#!/bin/bash
#


CURRENT_PATH=$(pwd)
SHELL_PATH=$(cd $(dirname $0); pwd)

echo "xkbcomp $SHELL_PATH/custom.xkb $DISPLAY"
xkbcomp "$SHELL_PATH/custom.xkb" $DISPLAY

# vim: ft=sh
