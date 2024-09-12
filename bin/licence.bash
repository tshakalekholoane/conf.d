#!/usr/bin/env bash
# Generates a licence file specified in the current directory.

readonly DIRECTORY="${HOME}/conf.d/bin/licence.d"
readonly PROGRAM="$(basename "$0")"

declare -A licence
licence["isc"]="isc.txt"

case "$1" in
  "" | -h)
    printf "usage: %s [-hl] licence\n" "${PROGRAM}"
    ;;
  -l)
    printf "%s\n" "${!licence[@]}"
    ;;
  *)
    readonly FILENAME="$(echo "${licence["$1"]}")"
    if [[ -z "${FILENAME}" || ! -e "${DIRECTORY}/${FILENAME}" ]]; then
      printf "%s: entry not found: %s\n" "${PROGRAM}" "$1" >&2
      exit 1
    fi
    printf "$(cat "${DIRECTORY}/${FILENAME}")" "$(date +%Y)" "Tshaka Lekholoane" > LICENCE
    ;;
esac
