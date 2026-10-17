#!/usr/bin/env bash
on=$(cat "$HOME/scripts/config/NightModeOn" 2>/dev/null || echo 0)
temp=$(cat "$HOME/scripts/config/NightModeTemp" 2>/dev/null || echo 4000)
if [ "$on" = "1" ]; then
    jq -cn --arg t "$temp" '{text:"󰖔", class:"on", tooltip:("Night mode on - " + $t + "K")}'
else
    echo '{"text":"󰖙","class":"off","tooltip":"Night mode off"}'
fi
