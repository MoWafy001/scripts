#!/bin/bash

redshift -O 4500 -b 0.8 -P

echo 1 > ~/scripts/config/nightmode
notify-send -t 1000 "Night Mode ON"
