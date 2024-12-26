#!/usr/bin/env bash
# Swaps Caps Lock with Esc in GNOME.

source "std/log.bash"

if [[ "$(uname)" != "Linux" ]]; then
  log::set_prefix "$(basename "$0"): "
  log::fatalf "incompatible operating system\n"
fi
gsettings set org.gnome.desktop.input-sources xkb-options "['caps:swapescape']"
