#!/usr/bin/env bash
#
# Sway lock screen: blurred screenshot + swaylock.
# Ported from the X11 version (xprop / scrot / imagemagick / i3lock).
# Original kept at lockscreen.sh.x11.bak

set -u

# Windows whose title should block an *automatic* lock (watching a video).
LIST_OF_WINDOW_TITLES_THAT_PREVENT_LOCKING=(
  "YouTube"
  "Prime Video"
)

SHOT="/tmp/sway-lock-$USER.png"

# ------------------------------------------------------------------
# Should we lock?  (replaces the xprop _NET_WM_STATE / _NET_WM_NAME probe)
# ------------------------------------------------------------------
should_lock() {
  # Nothing fullscreen -> always lock.
  local node
  node=$(swaymsg -t get_tree 2>/dev/null \
    | jq -r 'first(.. | objects | select(.focused? == true))') || return 0
  [ -z "$node" ] && return 0

  local fullscreen title
  fullscreen=$(printf '%s' "$node" | jq -r '.fullscreen_mode // 0')
  title=$(printf '%s' "$node" | jq -r '.name // ""')

  if [ "$fullscreen" != "0" ]; then
    for i in "${LIST_OF_WINDOW_TITLES_THAT_PREVENT_LOCKING[@]}"; do
      if [[ "$title" =~ $i ]]; then
        notify-send -t 2000 "$i prevented lockscreen"
        return 1
      fi
    done
  fi
  return 0
}

cleanup() { rm -f "$SHOT"; }

# ------------------------------------------------------------------
# Build the blurred background.  Echoes the file to use, or nothing.
# ------------------------------------------------------------------
make_background() {
  command -v grim >/dev/null || return 1
  grim -t png "$SHOT" 2>/dev/null || return 1

  # Blur with ImageMagick if it is installed (optional dependency).
  local im=""
  command -v magick  >/dev/null && im="magick"
  [ -z "$im" ] && command -v convert >/dev/null && im="convert"

  if [ -n "$im" ]; then
    # Downscale/upscale is much faster than a large-radius blur.
    "$im" "$SHOT" -resize 10% -blur 0x3 -resize 1000% "$SHOT" 2>/dev/null
  fi
  printf '%s' "$SHOT"
}

lock_sc() {
  trap cleanup HUP INT TERM EXIT

  # Make sure the password is typed in the latin layout, not ara.
  swaymsg input type:keyboard xkb_switch_layout 0 >/dev/null 2>&1

  local bg
  bg=$(make_background) || bg=""

  local args=(
    --daemonize
    --ignore-empty-password
    --show-failed-attempts
    --indicator-radius 100
    --indicator-thickness 8
    --ring-color        1f8f8f
    --ring-ver-color    4dd6d6
    --ring-wrong-color  d75f5f
    --key-hl-color      2bb3b3
    --bs-hl-color       d75f5f
    --inside-color      0f1f1fcc
    --inside-ver-color  132b2bcc
    --inside-wrong-color d75f5f55
    --separator-color   00000000
    --text-color        cfeeee
    --text-ver-color    cfeeee
    --text-wrong-color  cfeeee
    --line-color        00000000
  )

  if [ -n "$bg" ]; then
    args+=( --image "$bg" --scaling fill )
  else
    args+=( --color 0f1f1f )
  fi

  swaylock "${args[@]}"

  # --daemonize returns immediately; wait so swayidle's timeout command
  # does not fire again while the screen is already locked.
  while pgrep -x swaylock >/dev/null; do sleep 1; done
  cleanup
}

if pgrep -x swaylock >/dev/null; then
  exit 0            # already locked
fi

if should_lock; then
  lock_sc
fi
