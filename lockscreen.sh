#!/usr/bin/env sh
#
# Session dispatcher. Picks the X11 or Wayland implementation at runtime so
# the same path works from both ~/.config/i3/config and ~/.config/sway/config.
#
#   X11 / i3   -> ~/scripts/x11/lockscreen.sh      (original, unchanged)
#   Wayland/sway -> ~/scripts/wayland/lockscreen.sh
#
# Argument handling differs per backend - see each file.

if [ -n "${SWAYSOCK:-}" ] || [ -n "${WAYLAND_DISPLAY:-}" ] || \
   [ "${XDG_SESSION_TYPE:-}" = "wayland" ]; then
    exec "$HOME/scripts/wayland/lockscreen.sh" "$@"
else
    exec "$HOME/scripts/x11/lockscreen.sh" "$@"
fi
