#!/usr/bin/env bash
# Night mode ON (gammastep, the Wayland fork of redshift).

CONF_DIR="$HOME/scripts/config"
NightModeTemp="$(cat "$CONF_DIR/NightModeTemp" 2>/dev/null || echo 4000)"

pkill -x gammastep 2>/dev/null
# -P resets gamma first, -O is one-shot manual mode.
# On Wayland gammastep must keep running to hold the gamma ramp.
setsid -f gammastep -O "$NightModeTemp" -b 0.8 -P >/dev/null 2>&1

echo 1 > "$CONF_DIR/NightModeOn"
notify-send -t 1000 "Night Mode ON (${NightModeTemp}K)"
pkill -RTMIN+2 waybar 2>/dev/null
exit 0
