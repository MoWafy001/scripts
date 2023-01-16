#!/bin/sh

i3status | (read line && echo "$line" && read line && echo "$line" && read line && echo "$line" && while :
do
  read line
  echo ",[\
          {\"full_text\":\"test\", \"color\":\"#00FF00\" },\
          ${line#,\[}" || exit 1
done)
