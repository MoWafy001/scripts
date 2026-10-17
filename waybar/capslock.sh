#!/usr/bin/env bash
state=0
for led in /sys/class/leds/*::capslock/brightness; do
    [ -r "$led" ] || continue
    [ "$(cat "$led")" != "0" ] && state=1
done
if [ "$state" = "1" ]; then
    echo '{"text":"󰪛 CAPS","class":"on","tooltip":"Caps Lock is on"}'
else
    echo '{"text":"","class":"off","tooltip":"Caps Lock is off"}'
fi
