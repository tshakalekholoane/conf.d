#!/usr/bin/env bash
# Generate a gitignore file in the current directory.

readonly ROOT="${HOME}/rc.d/bin"
readonly REPOSITORY="${ROOT}/git_ignore.d"
readonly PROGRAM="$(basename "$0")"

source "${ROOT}/include/log.bash"

usage() {
  printf "usage: ${PROGRAM} [-hl] template\n\n"
  printf "Subcommands:\n"
  printf "  init   initialise repository\n"
  printf "  update update repository\n"
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
        if [[ ! -d "${REPOSITORY}" ]]; then
          log::fatalf "repository not initialised; run ${PROGRAM} init\n"
        fi
        ls -1 "${REPOSITORY}" | rg ".gitignore" --replace ""
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

  case "$1" in
    init)
      if [[ -d "${REPOSITORY}" ]]; then
        log::fatalf "repository already initialised\n"
      fi
      git clone --depth 1 "https://github.com/github/gitignore" "${REPOSITORY}"
      ;;
    update)
      if [[ ! -d "${REPOSITORY}" ]]; then
        log::fatalf "repository not initialised; run ${PROGRAM} init\n"
      fi
      cd "${REPOSITORY}"
      git pull --rebase
      ;;
    *)
      if [[ ! -e "${REPOSITORY}/$1.gitignore" ]]; then
        log::fatalf "$1.gitignore not found; run ${PROGRAM} -l to list available files\n"
      fi
      cp "${REPOSITORY}/$1.gitignore" ./.gitignore
  esac
}
