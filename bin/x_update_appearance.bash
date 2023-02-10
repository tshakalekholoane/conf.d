#!/usr/bin/env bash
# Sets the appearance for all terminal applications.

PROG="$(basename "$0")"

usage() { printf "usage:\t%s [dark|light]\n" $PROG; }

if [[ $# -eq 0 || $# -gt 1 ]]; then
	usage >&2
	exit 1
fi

case "$1" in
	"dark" | "light")
		alacritty_set_theme "$1"
		fish_set_theme "$1"
		nvim_set_background "$1"
		;;
	*)
		printf "%s: unrecognised option: %s\n" $PROG $1 >&2
		usage
		exit 1
		;;
esac
