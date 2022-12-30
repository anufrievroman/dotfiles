#!/bin/sh
# Show tiramisu notifications in polybar.

# How many seconds notification is displayed:
display_duration=7.0

# Maximum number of characters:
char_limit=150

# Replace app names with nerd font logos
use_nerd_font="true"


# Stop old tiramisu processes if any:
pgrep -x tiramisu >/dev/null && killall tiramisu

# Start a new tiramisu process:
tiramisu -o '#summary #body' |
    while read -r line; do
        
        # Replace app names with icons
        if [ $use_nerd_font == "true" ]; then
            line="$(echo "$line" | sed -r 's/Telegram Desktop//')"
            line="$(echo "$line" | sed -r 's/NordVPN//')"
            line="$(echo "$line" | sed -r 's/VLC//')"
            line="$(echo "$line" | sed -r 's/Kdenlive//')"
            line="$(echo "$line" | sed -r 's/Wifi//')"
            line="$(echo "$line" | sed -r 's/Firefox//')"
        fi

        # Cut notification by character limit:
        if [ "${#line}" -gt "$char_limit" ]; then
            line="$(echo "$line" | cut -c1-$((char_limit-1)))…"
        fi

        # Display notification for the duration time:
        echo "$line"
        sleep "$display_duration"
        echo " "
    done
