#!/usr/bin/env bash
# Generate the digest of a tar archive from its URL and copy it to the
# clipboard.

readonly PROGRAM="$(basename "$0")"

source "${HOME}/conf.d/bin/include/log.bash"

usage() {
  printf "usage: ${PROGRAM} [-h] url\n"
}

main() {
  if [[ "$(uname)" != "Darwin" ]]; then
    log::set_prefix "${PROGRAM}: "
    log::fatalf "incompatible operating system\n"
  fi

  while getopts "h" opt; do
    case "${opt}" in
      h)
        usage
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

  curl -Ls "$1" | shasum --algorithm 256 | cut -d ' ' -f1
}

main "$@"
