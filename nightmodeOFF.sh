#!/bin/bash

redshift -x

echo 0 > ~/scripts/config/NightModeOn
notify-send -t 1000 "Night Mode OFF"
