#!/usr/bin/env bash
# Prints a cheat sheet in $CONFIGS/cheat.d.

DIR="${HOME}/conf.d/bin/x_cheat.d"
PROG="$(basename "$0")"

case "$1" in
  "" | -h)
    printf "usage:\t%s\t[-hl|<name>]\n" "${PROG}"
    ;;
  -l)
    ls -1 "${DIR}" | sed -E 's/\.txt$//'
    ;;
  *)
    SHEET="${DIR}/$1.txt"
    if [[ ! -e "${SHEET}" ]]; then
      printf "%s: entry not found: %s\n" "${PROG}" "$1" >&2
      exit 1
    fi
    less --no-init --quit-if-one-screen --IGNORE-CASE --RAW-CONTROL-CHARS < "${SHEET}"
    ;;
esac
