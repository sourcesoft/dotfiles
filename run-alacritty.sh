#!/usr/bin/env bash

wid=$(xdotool search --onlyvisible --class Alacritty)

echo $wid

if [[ -z "$wid" ]]; then
	run-alacritty
fi


activews=$(xdotool get_desktop)
activeid=$(xdotool getactivewindow)
if [[ "$wid" == "$activeid" ]]; then
	xdotool windowminimize $wid
else
	xdotool set_desktop_for_window $wid $activews
	sleep 0.1
	xdotool windowactivate $wid
	xdotool windowsize $wid 100% 100%
fi
