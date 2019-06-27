#!/bin/sh

# this file is executed when calling startx

# to start a different WM, set session="WM" below, or in console run:
#    startx ~/.xinitrc WM

# session to run if none passed as first arg ($1)
session="${1:-awwm}"

# set environment wm for use in scripts
export WM="$session"

# default arch xinit scripts
if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/*.sh; do
        [ -x "$f" ] && . "$f"
    done
fi

# user init scripts and settings
[ -f /etc/X11/xinit/.Xmodmap ] && xmodmap /etc/X11/xinit/.Xmodmap
[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources
[ -f ~/.xprofile ] && source ~/.xprofile

# display timeout and sleep
xset s 3600 3600
xset dpms 3600 3700 4000

# keyboard repeat rate
xset r rate 400 50
kbdrate -d 400 -r 50

# dbus
dbus-update-activation-environment --all

# do NOT put commands below the exec lines
case $session in
    i3|i3wm)    exec i3 ;;

#		bspwm) ~/bin/lock.sh & exec bspwm ;;
		bspwm) exec bspwm ;;

		spectrwm)    exec spectrwm ;;

		dwm) ~/.config/dwm/autostart & exec dwm ;;

		hlwm) flashfocus & exec herbstluftwm --locked ;;

		frwm) flashfocus & ~/.config/frankenwm/autostart & exec frankenwm ;;

		awwm) flashfocus & compton -b & exec awesome ;;

		stumpwm) flashfocus & compton -b & exec stumpwm ;;
		
    *)          exec "$session" # Unknown, try running it
esac
