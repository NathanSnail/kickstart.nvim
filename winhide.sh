#!/usr/bin/env bash
# ~/.local/bin/winhide
win="$(bspc query -N -n focused)"
if [ -z "$(bspc query -N -n .hidden)" ]; then
  bspc node "$win" -g hidden=on
else
  bspc node "$(bspc query -N -n .hidden)" -g hidden=off
fi
