#!/usr/bin/env bash
# Toggle keyboard layout under sway.
# Layouts are declared in ~/.config/sway/config (input type:keyboard xkb_layout "us,ara").

swaymsg input type:keyboard xkb_switch_layout next >/dev/null

layout=$(swaymsg -t get_inputs | jq -r '[.[] | select(.type=="keyboard")][0].xkb_active_layout_name')
notify-send -t 1000 -h string:x-canonical-private-synchronous:layout "Layout: ${layout}"

# nudge waybar's sway/language module
pkill -RTMIN+1 waybar 2>/dev/null
exit 0
