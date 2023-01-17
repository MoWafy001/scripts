#!/bin/sh

# run i3status
i3status | (read line && echo "$line" && read line && echo "$line" && read line && echo "$line" && while :
do
  read line

  # load modules
  modulesJSON=$(eval ~/scripts/i3StatusCustomModules/modules)
  echo ",[$modulesJSON ${line#,\[}" || exit 1
done)
