#!/usr/bin/env bash
# Print code snippets to standard output.

readonly DIRECTORY="${HOME}/conf.d/bin/x_snip.d"
readonly PROGRAM="$(basename "$0")"

usage() {
  printf "usage: %s [-i] <lang> <snippet>\n" "${PROGRAM}"
}

main() {
  while getopts "hil" OPT; do
    case "${OPT}" in
      i)
        inline=1
        ;;
      h)
        usage
        exit
        ;;
      l)
        ls -1 "${DIRECTORY}"
        exit
        ;;
      \?)
        printf "%s: invalid option -%s\n" "${PROGRAM}" "${OPTARG}"
        usage
        exit 1
        ;;
    esac
  done

  shift $((OPTIND - 1))

  if [[ "$#" -ne 2 ]]; then
    usage
    exit 1
  fi

  local SNIPPET="${DIRECTORY}/$2.$1"
  if [[ ! -e "${SNIPPET}" ]]; then
    printf "%s: no such snippet: %s\n" "${PROGRAM}" "$(basename "${SNIPPET}")"
    exit 1
  fi

  if [[ "${inline}" -eq 1 ]]; then
    sed -e '1d;$d' "${SNIPPET}"
  else
    cat "${SNIPPET}"
  fi
}

main "$@"
