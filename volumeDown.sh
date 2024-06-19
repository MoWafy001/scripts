#!/bin/bash

VolumeStep="$(cat ~/projects/scripts/config/VolumeStep)"

pactl set-sink-volume @DEFAULT_SINK@ -"$VolumeStep"% && \
  notify-send $(~/projects/scripts/getCurrVolume.sh) -t 1000
