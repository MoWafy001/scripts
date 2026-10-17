#!/usr/bin/env bash
command -v bluetoothctl >/dev/null || exit 0
n=$(bluetoothctl devices Connected 2>/dev/null \
  | perl -pe 's/\e\[[0-9;]*[mGKH]//g' \
  | sed -E 's/^Device [^ ]+ //' \
  | paste -sd ', ' -)
[ -z "$n" ] && { echo '{"text":"","tooltip":"No bluetooth device connected"}'; exit 0; }
jq -cn --arg n "$n" '{text: ("󰂯 " + $n), tooltip: ("Connected: " + $n), class: "connected"}'
