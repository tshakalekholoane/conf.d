#!/usr/bin/env bash
# Swaps Caps Lock with Esc in GNOME.

if [[ "$(uname -s)" != "Linux" ]]; then
  printf "%s: incompatible system\n" "$(basename "$0")"
  exit 1
fi
gsettings set org.gnome.desktop.input-sources xkb-options "['caps:swapescape']"
