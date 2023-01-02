#!/bin/bash

connected_display_list() {
  for display in $(xrandr | grep " connected " | cut -d" " -f 1); do
    for except in "$@"; do
      [[ $display =~ $except ]] && continue || echo $display
    done
  done
}

# Terminate alread running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do
  sleep 1;
done

# Launch Polybar, using default config location ~/.config/polybar/config
polybar example &

# for display in $(connected_display_list "LVDS"); do
#   echo "Set $display"
#   MONITOR="$display" polybar example2 &
# done


echo "Polybar launched..."
