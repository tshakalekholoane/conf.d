#!/usr/bin/env bash
# Generates a licence file specified in the current directory.

readonly ROOT="${HOME}/conf.d/bin"
readonly DIRECTORY="${ROOT}/licence.d"
readonly PROGRAM="$(basename "$0")"

source "${ROOT}/include/log.bash"

declare -A licence
licence["isc"]="isc.txt"

usage() {
  printf "usage: ${PROGRAM} [-hl] licence\n"
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
        echo "${!licence[@]}" | tr ' ' '\n'
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

  readonly FILENAME="$(printf "${licence["$1"]}")"
  if [[ -z "${FILENAME}" || ! -e "${DIRECTORY}/${FILENAME}" ]]; then
    log::fatalf "entry not found: $1\n"
  fi
  printf "$(cat "${DIRECTORY}/${FILENAME}")" "$(date +%Y)" "Tshaka Lekholoane" > LICENCE
}

main "$@"
