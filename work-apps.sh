#!/bin/bash

# Firefox
nohup firefox >/dev/null 2>&1 &
notify-send -t 1000 "FireFox started"

# chromium sptify
nohup chromium open.spotify.com >/dev/null 2>&1 &
notify-send -t 1000 "Spotify started"

# vscode sukuk
nohup code ~/Desktop/sukuk_backend/ >/dev/null 2>&1 &
notify-send -t 1000 "VSCode Sukuk Started"

# postman
nohup postman >/dev/null 2>&1 &
notify-send -t 1000 "Postman Started"

# hivedisk
nohup ~/Downloads/HiveDesk+6.0.3.AppImage >/dev/null 2>&1 &
notify-send -t 1000 "HiveDesk Started"
