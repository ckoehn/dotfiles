#!/bin/zsh

COLOR=${1:-000000}

revert() {
	killall -SIGUSR2 dunst
	xset dpms 0 0 0
}

trap revert HUP INT TERM
killall -SIGUSR1 dunst
xset dpms 10 10 10

i3lock -u -c $COLOR -n
revert
