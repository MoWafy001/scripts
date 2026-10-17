#!/usr/bin/env bash
# Usage: screenshot.sh [region|full|window]
# Saves to ~/Pictures/Screenshots and copies to the Wayland clipboard.

mode="${1:-region}"
dir="$HOME/Pictures/Screenshots"
mkdir -p "$dir"
file="$dir/$(date +%Y-%m-%d_%H-%M-%S).png"

case "$mode" in
  region)
    geom=$(slurp) || exit 0          # Esc / right-click cancels
    grim -g "$geom" "$file" || exit 1
    msg="Region captured"
    ;;
  window)
    geom=$(swaymsg -t get_tree \
      | jq -r '.. | select(.focused? == true) | .rect
               | "\(.x),\(.y) \(.width)x\(.height)"') || exit 1
    grim -g "$geom" "$file" || exit 1
    msg="Window captured"
    ;;
  full|*)
    grim "$file" || exit 1
    msg="Full screen captured"
    ;;
esac

wl-copy --type image/png < "$file"
notify-send -t 1500 -i "$file" "$msg" "$(basename "$file")"
