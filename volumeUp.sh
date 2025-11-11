#!/bin/bash

max_volume_pc=$1
current_volume_pc=$(~/scripts/getCurrVolume.sh)
VolumeStep="$(cat ~/scripts/config/VolumeStep)"

if (($(echo -n $current_volume_pc | wc -m) == 0)); then
	current_volume_pc=$(pamixer --get-volume)
fi

if (($current_volume_pc < $max_volume_pc-"$VolumeStep")) ; then
    pamixer --allow-boost -i "$VolumeStep" && $refresh_i3status
else
    pamixer --allow-boost --set-volume "$max_volume_pc" && $refresh_i3status
fi

current_volume_pc=$(~/scripts/getCurrVolume.sh)
notify-send $current_volume_pc -t 1000
