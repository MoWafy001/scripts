#!/bin/bash

NightModeTemp="$(cat ~/projects/scripts/config/NightModeTemp)"

redshift -O "$NightModeTemp" -b 0.8 -P

echo 1 > ~/projects/scripts/config/NightModeOn
notify-send -t 1000 "Night Mode ON"
