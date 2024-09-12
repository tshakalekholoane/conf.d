#!/usr/bin/env bash
# Generates a configuration file for the language (formatter) specified
# in the current directory.

readonly DIRECTORY="${HOME}/conf.d/bin/format.d"
readonly PROGRAM="$(basename "$0")"

declare -A configuration_file
configuration_file["c"]=".clang-format"
configuration_file["rust"]="rustfmt.toml"
configuration_file["swift"]=".swiftformat"

case "$1" in
  "" | -h)
    printf "usage:\t%s [-hl|<language>]\n" "${PROGRAM}"
    ;;
  -l)
    printf "%s\n" "${!configuration_file[@]}"
    ;;
  *)
    readonly FILENAME="$(echo "${configuration_file["$1"]}")"
    if [[ -z "${FILENAME}" || ! -e "${DIRECTORY}/${FILENAME}" ]]; then
      printf "%s: entry not found: %s\n" "${PROGRAM}" "$1" >&2
      exit 1
    fi
    cp "${DIRECTORY}/${FILENAME}" "${PWD}"
    ;;
esac
