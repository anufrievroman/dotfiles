#!/usr/bin/sh
if (($(ps -aux | grep [p]icom | wc -l) > 0))
then
  polybar-msg hook blur-toggle 1
  pkill -9 picom
else
  polybar-msg hook blur-toggle 2
  picom -b --config=/home/r/.config/picom/picom.conf --experimental-backends --backend glx --blur-method dual_kawase &
fi
