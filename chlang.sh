#!/usr/bin/bash
layout=$(
  setxkbmap -query | 
    grep "layout" |
      sed "s/layout:    //"
)

if [ $layout == 'us,ar' ];
then
  setxkbmap ar,us
else
  setxkbmap us,ar
fi
