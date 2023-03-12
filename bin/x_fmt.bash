#!/usr/bin/env bash
# Generates a configuration file for the language (formatter) specified
# in the current directory.

DIR="${HOME}/conf.d/bin/x_fmt.d"
PROG="$(basename "$0")"

declare -A files
files["c"]=".clang-format"
files["rust"]="rustfmt.toml"
files["swift"]=".swiftformat"

case "$1" in
  "" | -h)
    printf "usage:\t%s [-hl|<language>]\n" "${PROG}"
    ;;
  -l)
    printf "%s\n" "${!files[@]}"
    ;;
  *)
    CONFIG="$(echo "${files["$1"]}")"
    if [[ -z "${CONFIG}" || ! -e "${DIR}/${CONFIG}" ]]; then
      printf "%s: entry not found: %s\n" "${PROG}" "$1" >&2
      exit 1
    fi
    cp "${DIR}/${CONFIG}" "${PWD}"
    ;;
esac
