#!/usr/bin/env bash
# Shorten a URL.

readonly PROGRAM="$(basename "$0")"
readonly ROOT="${HOME}/rc.d/bin"
readonly SERVICE_URL="https://tshaka.dev/a/" 

source "${ROOT}/include/log.bash"

usage() {
  printf "usage: ${PROGRAM} url\n"
}

main() {
  log::set_prefix "${PROGRAM}: "

  if [[ "$#" -ne 1 ]]; then
    log::errorf "invalid number of arguments\n"
    usage
    exit 2
  fi

  curl --data "$1" --user $(cat ~/.config/tiny/config) "${SERVICE_URL}"
}

main "$@"
