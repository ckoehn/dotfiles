#!/bin/sh
# vim:ts=4:sw=4:expandtab

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

xrdb -load ~/.Xresources

setxkbmap de
xmodmap ~/.Xmodmap

xset r rate 200 40

exec i3
