#!/bin/sh

player_status=$(playerctl status 2>/dev/null)

title=$(playerctl metadata title)
if artist=$(playerctl metadata artist); then
  song_info="${title} - ${artist}"
else
  song_info="${title}"
fi

if [ "$player_status" = "Playing" ]; then
  output="${song_info}"
elif [ "$player_status" = "Paused" ]; then
  output="⏯ ${song_info}"
fi

echo $output
