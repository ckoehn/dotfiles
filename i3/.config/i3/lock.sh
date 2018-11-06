#!/bin/zsh

killall -SIGUSR1 dunst
xset dpms 5 5 5

i3lock -u -c $1 -n

killall -SIGUSR2 dunst
xset dpms 0 0 0
