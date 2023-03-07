#!/usr/bin/env bash

# Minimal package manager. To add a package, create a Bash script in
# x_pkg.d and implement the functions install and upgrade for that
# package e.g. package_name::install () { # Installation logic.; }.

set -e

PROG="$(basename "$0")"
DIR="${HOME}/src"

usage() {
	printf "usage:\t%s [-h] [install|upgrade] <package>\n" "${PROG}"
}

load_instructions() {
	instructions="${HOME}/conf.d/bin/x_pkg.d/$1.bash"
	if [[ ! -e "${instructions}" ]]; then
		printf "%s: instructions not found: %s\n" "${PROG}" "$1" >&2
		exit 1
	fi
	. "${instructions}"
}

if [[ "$#" -eq 0 || "$#" -eq 1 || "$#" -gt 2 ]]; then
	printf "%s: invalid number of arguments\n" "${PROG}" >&2
	usage
	exit 1
fi

case "$1" in
	-h)
		usage
		;;
	install)
		if [[ -e "${DIR}/$2" ]]; then
			printf "%s: source already exists\n" "${PROG}"
			exit 1
		fi
		cd "${DIR}"
		load_instructions "$2"
		"$2"::install
		;;
	upgrade)
		cd "${DIR}/$2"
		load_instructions "$2"
		"$2"::upgrade
		;;
	*)
		printf "%s: unrecognised option: %s\n" "${PROG}" "$1" >&2
		usage
		exit 1
		;;
esac
