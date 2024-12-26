#!/usr/bin/env bash
# Print code snippets to standard output.

source "std/log.bash"

readonly DIRECTORY="${HOME}/conf.d/bin/snip.d"
readonly PROGRAM="$(basename "$0")"

usage() {
  printf "usage: ${PROGRAM} [-hl] <snippet>\n"
}

main() {
  log::set_prefix "${PROGRAM}: "

  while getopts "hl" opt; do
    case "${opt}" in
      h)
        usage
        exit
        ;;
      l)
        ls -1 "${DIRECTORY}"
        exit
        ;;
      \?)
        usage
        exit 1
        ;;
    esac
  done

  shift $((OPTIND - 1))

  if [[ "$#" -ne 1 ]]; then
    usage
    exit 1
  fi

  local SNIPPET="${DIRECTORY}/$1"
  if [[ ! -e "${SNIPPET}" ]]; then
    log::fatalf "no such snippet: $(basename "${SNIPPET}")\n"
  fi
  cat "${SNIPPET}"
}

main "$@"
