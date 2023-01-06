#!/bin/bash

pactl set-sink-volume @DEFAULT_SINK@ -5% && \
  notify-send $(~/scripts/getCurrVolume.sh) -t 1000
