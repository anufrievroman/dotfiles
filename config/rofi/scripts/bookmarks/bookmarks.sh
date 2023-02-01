#!/bin/sh

# cat $(dirname $0)/bookmarks.txt | rofi -dmenu -i -p "" | cut -d\- -f2- | xclip -selection clipboard
ADDRESS=$(cat $(dirname $0)/bookmarks.txt | rofi -dmenu -i -p "" | cut -d\- -f2-)
if [ -n "$ADDRESS" ]; then
    brave -e $ADDRESS
    i3-msg workspace number 2
fi
