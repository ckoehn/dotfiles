#!/bin/zsh

BG_COLOR=${1:-000000}
FONT_COLOR=${2:-FF0000FF}

revert() {
	killall -SIGUSR2 dunst
	xset dpms 0 0 0
}

trap revert HUP INT TERM
killall -SIGUSR1 dunst
xset dpms 10 10 10

i3lock -u -c ${BG_COLOR} -n \
	-k \
	--timecolor=${FONT_COLOR} --datecolor=${FONT_COLOR} \
	--time-font=Hack --date-font=Hack \
	--datestr='%A %d.%m'

revert
