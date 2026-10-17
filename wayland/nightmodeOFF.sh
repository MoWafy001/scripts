#!/usr/bin/env bash
# Night mode OFF.

CONF_DIR="$HOME/scripts/config"

pkill -x gammastep 2>/dev/null
# clear any lingering gamma ramp
gammastep -x >/dev/null 2>&1

echo 0 > "$CONF_DIR/NightModeOn"
notify-send -t 1000 "Night Mode OFF"
pkill -RTMIN+2 waybar 2>/dev/null
exit 0
