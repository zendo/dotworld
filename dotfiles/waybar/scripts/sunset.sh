#!/bin/sh

# if [ "$player_status" = "Playing" ]; then
#     output="${song_info}"
# elif [ "$player_status" = "Paused" ] ; then
#     output="⏯ ${song_info}"
# fi

SERVICE=wlsunset

is_running() {
  pgrep "$SERVICE" >/dev/null
}

if is_running; then
  wlsunset &
else
  wlsunset -l 22 -L 114 &
fi
