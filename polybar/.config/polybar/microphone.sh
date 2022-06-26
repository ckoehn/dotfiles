#!/bin/sh

set -o errexit
set -o errtrace
set -o nounset
# set -o xtrace

index=$(pacmd list-sources | grep "\* index:" | cut -d' ' -f5)
muted=$(pacmd list-sources | grep "index: $index" -A 11 | grep "muted" | awk -F: '{print $2}' | tr -d ' ')

if [ "$muted" = "yes" ]; then
  echo '-'
else
  volume=$(pacmd list-sources | grep "index: $index" -A 7 | grep "volume" | awk -F/ '{print $2}' | tr -d ' ')
  echo "$volume"
fi
