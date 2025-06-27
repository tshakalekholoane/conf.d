#!/usr/bin/env bash
# Generates a configuration file for the language (formatter) specified
# in the current directory.

readonly ROOT="${HOME}/rc.d/bin"
readonly DIRECTORY="${ROOT}/format.d"
readonly PROGRAM="$(basename "$0")"

source "${ROOT}/include/log.bash"

declare -A configuration_file
configuration_file["c"]=".clang-format"
configuration_file["rust"]="rustfmt.toml"
configuration_file["swift"]=".swiftformat"

usage() {
  printf "usage:\t${PROGRAM} [-hl|<language>]\n"
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
        echo "${!configuration_file[@]}" | tr ' ' '\n'
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

  readonly FILENAME="$(printf "${configuration_file["$1"]}")"
  if [[ -z "${FILENAME}" || ! -e "${DIRECTORY}/${FILENAME}" ]]; then
    log::fatalf "entry not found: $1\n"
  fi
  cp "${DIRECTORY}/${FILENAME}" "${PWD}"
}

main "$@"
