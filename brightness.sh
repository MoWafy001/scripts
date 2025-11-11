#!/bin/bash

STEP=5   # step size in %

# Adjust brightness with brightnessctl
if [[ "$1" == "Up" || "$1" == "+" ]]; then
    brightnessctl set +${STEP}%
elif [[ "$1" == "Down" || "$1" == "-" ]]; then
    brightnessctl set ${STEP}%-
fi

# Get current brightness in percent (without % sign)
Percent=$(brightnessctl -m | cut -d, -f4 | tr -d '%')

# Show notification
notify-send -t 1000 "Brightness: ${Percent}%"

