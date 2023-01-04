#!/bin/bash
# 
# NAME:   highspeed_keyrepeat.sh
# AUTHOR: marsh
#
# NOTE:
#
#   xset r rate [delay [rate]]
#
# `delay` is the wait time (ms) for a series of hits when a key is held down.
# `rate`  is the frequency (Hz) to be struck in succession.

delay="200"
rate="80"

xset r rate "$delay" "$rate"

cat<<EOF
xset r rate $delay $rate

If you want to laod key repeat setting automatically,
write \`xset r rate $delay $rate\` on \`~/.bashrc\` or \`~/.profile\`.
EOF
