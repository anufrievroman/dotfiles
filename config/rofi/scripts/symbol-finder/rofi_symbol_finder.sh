#!/bin/sh

cat $(dirname $0)/symbol-list.txt | rofi -dmenu -i -p "Icon" | cut -f 1 | xclip -selection clipboard
