#!/usr/bin/env bash

status=$(bluetoothctl -- show E8:B1:FC:CC:E6:23 | grep 'Powered: yes')
if [[ -n $status ]]; then
  bluetoothctl -- power off
else
  bluetoothctl -- power on
fi
