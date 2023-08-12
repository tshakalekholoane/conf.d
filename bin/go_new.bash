#!/usr/bin/env bash
# Creates a new Go project.

readonly PROGRAM="$(basename "$0")"

usage() {
  printf "usage:\t%s [-hl] <module>\n" "${PROGRAM}"
}

module() {
  mkdir "$1" && cd "$1"
  go mod init "$2"
  go work use . 2> /dev/null
}

main() {
  LIBRARY=0
  while getopts "hl" OPTION; do
    case "${OPTION}" in
      h)
        usage
        exit
        ;;
      l)
        LIBRARY=1
        ;;
      *)
        usage >&2
        exit 1
        ;;
    esac
  done

  shift $((OPTIND - 1))

  if [[ "$#" -eq 0 ]]; then
    usage
    exit
  fi

  readonly DIRECTORY="${HOME}/conf.d/bin/go_new.d"
  readonly PACKAGE="$(basename "$1")"
  if [[ -d "${PACKAGE}" ]]; then
    printf "%s: directory with the same name already exists: %s\n" "${PROGRAM}" "${PACKAGE}" >&2
    exit 1
  fi
  module "${PACKAGE}" "$1"
  if [[ "${LIBRARY}" -eq 1 ]]; then
    cp "${DIRECTORY}/package.go" "${PACKAGE}.go"
    cp "${DIRECTORY}/package_test.go" "${PACKAGE}_test.go"
    sed -i '' "s/sample_package_name/${PACKAGE}/" "${PACKAGE}.go"
    sed -i '' "s/sample_package_name/${PACKAGE}/" "${PACKAGE}_test.go"
  else
    cp "${DIRECTORY}/binary.go" main.go
  fi
  if [[ ! "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = "true" ]]; then
    git init
  fi
}

main "$@"
