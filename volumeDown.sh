#!/bin/bash

VolumeStep="$(cat ~/scripts/config/VolumeStep)"

pamixer --allow-boost -d "$VolumeStep" && \
  notify-send $(~/scripts/getCurrVolume.sh) -t 1000
