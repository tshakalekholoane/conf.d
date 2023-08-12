#!/usr/bin/env bash
# Generates a configuration file for the language (formatter) specified
# in the current directory.

DIRECTORY="${HOME}/conf.d/bin/x_fmt.d"
PROGRAM="$(basename "$0")"

declare -A files
files["c"]=".clang-format"
files["rust"]="rustfmt.toml"
files["swift"]=".swiftformat"

case "$1" in
  "" | -h)
    printf "usage:\t%s [-hl|<language>]\n" "${PROGRAM}"
    ;;
  -l)
    printf "%s\n" "${!files[@]}"
    ;;
  *)
    CONFIGURATION="$(echo "${files["$1"]}")"
    if [[ -z "${CONFIGURATION}" || ! -e "${DIRECTORY}/${CONFIGURATION}" ]]; then
      printf "%s: entry not found: %s\n" "${PROGRAM}" "$1" >&2
      exit 1
    fi
    cp "${DIRECTORY}/${CONFIGURATION}" "${PWD}"
    ;;
esac
