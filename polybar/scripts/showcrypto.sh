#!/usr/bin/env bash

polybar cryptobar &
sleep 10
kill $(pgrep polybar | tail -n 1)
