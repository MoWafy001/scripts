#!/bin/sh

scrot -s -f -F /tmp/screenshot.png && \
  notify-send -t 1000 "screen shot taken" && \
  xclip -selection clipbloard -t image/png -i /tmp/screenshot.png && \
  rm /tmp/screenshot.png
