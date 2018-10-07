#!/bin/zsh
# vim:ts=4:sw=4:expandtab

killall -q polybar
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

# https://github.com/jaagr/polybar/issues/763
for m in $(polybar --list-monitors | cut -d":" -f1); do
    MONITOR=$m polybar --reload top &
done
