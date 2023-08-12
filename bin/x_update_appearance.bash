#!/usr/bin/env bash
# Sets the appearance for all terminal applications.

PROGRAM="$(basename "$0")"

usage() {
  printf "usage:\t%s {dark,light}\n" "${PROGRAM}"
}

if [[ "$#" -eq 0 ]]; then
  usage
  exit
fi

case "$1" in
  dark | light)
    alacritty_set_theme "$1"
    fish_set_theme "$1"
    nvim_set_background "$1"
    ;;
  *)
    printf "%s: unrecognised option: %s\n" "${PROGRAM}" "$1" >&2
    usage
    exit 1
    ;;
esac
