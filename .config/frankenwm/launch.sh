#!/usr/bin/env bash
# ~/.config/bspwm/launch.sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
polybar -q -c ~/.config/frankenwm/config-polybar frwm &

#notify-send "welcome to bspwm"
