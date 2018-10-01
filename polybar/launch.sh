#!/bin/sh
# vim:ts=4:sw=4:expandtab

killall -q polybar
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done
polybar top &
