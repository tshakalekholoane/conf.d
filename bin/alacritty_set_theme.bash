#!/usr/bin/env bash
# Sets the terminal theme.

CONFIG="${HOME}/.config/alacritty/alacritty.yml"
PROG="$(basename "$0")"
THEME="$(rg 'themes' "${CONFIG}" --no-line-number | sed -E "s|\"||g; s|^  - ~/|${HOME}/|g")"

usage() {
  printf "usage:\t%s {dark,light}\n" "${PROG}"
}

if [[ "$#" -eq 0 ]]; then
  usage
  exit
fi

case "$1" in
  dark | light)
    sed -E -i '' "s/\*(dark|light)\$/*$1/" "${THEME}"
    ;;
  *)
    printf "%s: unrecognised option: %s\n" "${PROG}" "$1" >&2
    usage
    exit 1
    ;;
esac
