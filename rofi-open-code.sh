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

# Get folder names in the projects directory
projects_dir="$HOME/projects"
options=($(ls "$projects_dir"))

options_str=$(join_by '\n' "${options[@]}" )
selection=$(echo -e $options_str | rofi -dmenu -p projects)

# Find the selected folder path
selected_folder=""
for option in "${options[@]}"; do
    if [[ "$option" == "$selection" ]]; then
        selected_folder="$projects_dir/$option"
        break
    fi
done

# Change directory into the selected folder and open it in a new Terminator session with nvim
if [ -n "$selected_folder" ]; then
    cd "$selected_folder" && terminator -e "source ~/.zshrc && nvim" > /dev/null 2>&1 &
fi

