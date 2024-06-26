#!/bin/bash

max_volume_pc=$1
current_volume_pc=$(~/projects/scripts/getCurrVolume.sh)
VolumeStep="$(cat ~/projects/scripts/config/VolumeStep)"

if (($(echo -n $current_volume_pc | wc -m) == 0)); then
    current_volume_pc=$(pactl list sinks | grep '^[[:space:]]Volume:' | head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')
fi

if (($current_volume_pc < $max_volume_pc-"$VolumeStep")) ; then
    pactl set-sink-volume @DEFAULT_SINK@ +"$VolumeStep"% && $refresh_i3status
else
    a=$(($max_volume_pc - $current_volume_pc))
    pactl set-sink-volume @DEFAULT_SINK@ +$a% && $refresh_i3status
fi

current_volume_pc=$(~/projects/scripts/getCurrVolume.sh)
notify-send $current_volume_pc -t 1000
