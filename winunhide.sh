#!/usr/bin/env bash
bspc query -N -n .hidden | xargs -I {} bspc node {} -g hidden=off
