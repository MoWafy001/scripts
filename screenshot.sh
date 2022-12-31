#!/bin/bash

extraArgs=( "$@" )
extraArgs="${extraArgs[@]:1}"
msg=$1

scrot $extraArgs -F /tmp/screenshot.png && \
  notify-send -t 1000 "$msg" && \
  xclip -selection clipbloard -t image/png -i /tmp/screenshot.png && \
  rm /tmp/screenshot.png
