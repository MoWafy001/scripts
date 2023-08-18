#!/bin/bash

##
# source for this section: https://github.com/clayboone/scripts/blob/master/auto_lock_screen.sh
# Settings
declare -a LIST_OF_WINDOW_TITLES_THAT_PREVENT_LOCKING=( 
  "YouTube" 
)

# Dependencies
AWK=/usr/bin/awk
GREP=/usr/bin/grep
XPROP=/usr/bin/xprop

# Find active window id
get_active_id() {
    $XPROP -root | $AWK '$1 ~ /_NET_ACTIVE_WINDOW/ { print $5 }'
}

# Determine a window's title text by it's ID
get_window_title() {
    # For mplayer or vlc, we might need to check WM_CLASS(STRING), idk.
    $XPROP -id $1 | $AWK -F '=' '$1 ~ /_NET_WM_NAME\(UTF8_STRING\)/ { print $2 }'
}

# Determine if a window is fullscreen based on it's ID
is_fullscreen() {
    $XPROP -id $1 | $AWK -F '=' '$1 ~ /_NET_WM_STATE\(ATOM\)/ { for (i=2; i<=3; i++) if ($i ~ /FULLSCREEN/) exit 0; exit 1 }'
    return $?
}

# Determine if the locker command should run based on which windows are
# fullscreened.
should_lock() {
    id=$(get_active_id)
    title=$(get_window_title $id)

    if is_fullscreen $id; then
        for i in "${LIST_OF_WINDOW_TITLES_THAT_PREVENT_LOCKING[@]}"; do
            if [[ $title =~ $i ]]; then
                notify-send "$i prevented lockscreen" -t 2000
                return 1
            fi
        done
    else
        return 0
    fi
}
##

revert() {
  rm /tmp/*screen*.png
  xset dpms 0 0 0
}

lock_sc() {
  trap revert HUP INT TERM
  xset +dpms dpms 0 0 5
  scrot -d 1 /tmp/locking_screen.png
  convert -blur 0x8 /tmp/locking_screen.png /tmp/screen_blur.png
  # convert -composite /tmp/screen_blur.png ~/Pictures/lockBG.png -gravity South -geometry -20x1200 /tmp/screen.png
  setxkbmap us,ar
  # i3lock -i /tmp/screen.png
  i3lock -i /tmp/screen_blur.png
  revert
}

if should_lock; then
  lock_sc
else
  xset s reset
fi
