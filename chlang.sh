#!/usr/bin/bash
layout=$(
  setxkbmap -query | 
    grep "layout" |
      sed "s/layout:    //"
)

if [ $layout == 'us' ];
then
  setxkbmap ar
else
  setxkbmap us
fi
