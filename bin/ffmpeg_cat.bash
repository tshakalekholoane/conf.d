#!/usr/bin/env bash
# Concatenate video files. The files should have the same encoding.

readonly ROOT="${HOME}/conf.d/bin"
readonly PROGRAM="$(basename "$0")"

source "${ROOT}/include/log.bash"

usage() {
  printf "usage: ${PROGRAM} -o output file 1 [file2 ...]\n"
}

main() {
  log::set_prefix "${PROGRAM}: "

  if [[ "$#" -lt 3 ]]; then
    log::errorf "invalid number of arguments\n"
    usage
    exit 2
  fi

  local output=""
  local input=()

  while [[ "$#" -gt 0 ]]; do
    case "$1" in
      -o)
        shift
        output="$1"
        ;;
      -*)
        log::errorf "unrecognised option: $1\n"
        usage
        exit 2
        ;;
      *)
        input+=("$1")
        ;;
    esac
    shift
  done

  if [[ -z "${output}" ]]; then
    log::errorf "output file not specified\n"
    usage
    exit 2
  fi

  if [[ "${#input[@]}" -lt 2 ]]; then
    log::errorf "at least two input files are required\n"
    usage
    exit 2
  fi

  local file_list=$(mktemp)
  for f in "${input[@]}"; do
    if [[ ! -f "${f}" ]]; then
      can "${file_list}"
      log::fatalf "file not found: ${f}\n"
    fi
    echo "file '${PWD}/${f}'" >> "${file_list}"
  done

  ffmpeg -f concat -safe 0 -i "${file_list}" -c copy "${output}"

  can "${file_list}"
}

main "$@"
