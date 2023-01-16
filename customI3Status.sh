#!/bin/sh

# run i3status
i3status | (read line && echo "$line" && read line && echo "$line" && read line && echo "$line" && while :
do
  # load modules
  modulesJSON=$(eval ~/scripts/i3StatusCustomModules/modules)

  read line
  echo ",[$modulesJSON ${line#,\[}" || exit 1
done)
