#!/bin/sh

while :
do
  echo $(date) started >> ~/Desktop/i3logs/i3status.log
  # run i3status
  i3status 2> ~/Desktop/i3logs/i3status-err.log | (read line && echo "$line" && read line && echo "$line" && read line && echo "$line" && while :
  do
    read line

    # load modules
    modulesJSON=$(eval ~/scripts/i3StatusCustomModules/modules)
    echo $line >> ~/Desktop/i3logs/i3status.log 
    echo $modulesJSON >> ~/Desktop/i3logs/i3status.log 
    echo ",[$modulesJSON ${line#,\[}" || exit 1
  done)
  echo $(date) restarted >> ~/Desktop/i3logs/i3status.log 
done

notify-send "stopped"
