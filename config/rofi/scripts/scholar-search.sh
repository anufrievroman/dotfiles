#!/usr/bin/env bash

query=$( (echo ) | rofi  -dmenu -i -lines 0 -matching fuzzy -location 0 -p " " )

if [[ -n "$query" ]]; then
  url=https://scholar.google.com/scholar?q=$query
  xdg-open "$url"
else
  exit
fi

exit 0
