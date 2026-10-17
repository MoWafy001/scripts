#!/usr/bin/env bash
# Waybar wrapper around ~/scripts/i3sm/modules/i3message (unchanged, still used by i3bar).
out=$(bash "$HOME/scripts/i3sm/modules/i3message" 2>/dev/null) || exit 0
printf '%s' "${out%,}" | jq -c '
  { text:    ("<span color=\"" + (.color // "#FF9F00") + "\">" + .full_text + "</span>"),
    tooltip: .full_text,
    class:   "fact" }' 2>/dev/null
