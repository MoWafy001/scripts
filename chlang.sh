#!/usr/bin/bash
layout=$(
  setxkbmap -query | 
    grep "layout" |
      sed "s/layout:    //"
)

if [ $layout == 'us,ara' ];
then
  setxkbmap ara,us
else
  setxkbmap us,ara
fi
