#!/usr/bin/env bash

polybar traybar &
sleep 10
kill $(pgrep polybar | tail -n 1)
