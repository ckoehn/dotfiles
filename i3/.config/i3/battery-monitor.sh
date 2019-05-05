#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o nounset
# set -o xtrace

while true
do
	state=$(acpi | head -1 | awk '{print $3}')
	charge=$(acpi | head -1 | grep -P -o '[0-9]+(?=%)')

	if [ "$state" = 'Discharging,' ]; then
		if [ "$charge" -le 10 ]; then
			notify-send -u critical "Battery: ${charge}% remaining"
		elif [ "$charge" -le 20 ]; then
			notify-send -u normal "Battery: ${charge}% remaining"
		fi
	fi

	sleep 300
done
