#!/bin/bash

VolumeStep="$(cat ~/scripts/config/VolumeStep)"

pactl set-sink-volume @DEFAULT_SINK@ -"$VolumeStep"% && \
  notify-send $(~/scripts/getCurrVolume.sh) -t 1000
