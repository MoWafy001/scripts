#!/usr/bin/bash

if [ x"$@" = x"quit" ]
then
    exit 0
fi

function join_by {
  local d=${1-} f=${2-}
  if shift 2; then
    printf %s "$f" "${@/#/$d}"
  fi
}

options=(
    Auth
    Property
    "Zajil API"
    Sukuk
  )

options_str=$(join_by '\n' "${options[@]}" )
selection=$(echo -e $options_str | rofi -dmenu -p projects)

case $selection in
  ${options[0]}) # auth
    coproc ( code ~/Desktop/auth  > /dev/null  2>&1 )
    ;;
  ${options[1]}) # property
    coproc ( code ~/Desktop/property-vertical  > /dev/null  2>&1 )
    ;;
  ${options[2]}) # Zajil API
    coproc ( code ~/Desktop/zajil/api  > /dev/null  2>&1 )
    ;;
  ${options[3]}) # Sukuk
    coproc ( code ~/Desktop/sukuk_backend  > /dev/null  2>&1 )
    ;;
esac

