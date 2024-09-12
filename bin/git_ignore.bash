#!/usr/bin/env bash
# Generate a gitignore file in the current directory.

readonly REPOSITORY="${HOME}/conf.d/bin/git_ignore.d"
readonly PROGRAM="$(basename "$0")"

fatalln() {
  echo "$*" >& 2
  exit 1
}

case "$1" in
  "" | -h)
    printf "usage: %s [-hl] template\n" "${PROGRAM}"
    ;;
  ls)
    if [[ ! -d "${REPOSITORY}" ]]; then
      fatalln "${PROGRAM}: repository not initialised, run ${PROGRAM}: init"
    fi
    ls -1 "${REPOSITORY}" | rg ".gitignore" --replace ""
    ;;
  init)
    if [[ -d "${REPOSITORY}" ]]; then
      fatalln "${PROGRAM}: repository already initialised"
    fi
    git clone --depth 1 "https://github.com/github/gitignore" "${REPOSITORY}"
    ;;
  update)
    if [[ ! -d "${REPOSITORY}" ]]; then
      fatalln "${PROGRAM}: repository not initialised, run ${PROGRAM} init"
    fi
    cd "${REPOSITORY}"
    git pull --rebase
    ;;
  *)
    if [[ ! -e "${REPOSITORY}/$1.gitignore" ]]; then
      fatalln "${PROGRAM}: $1.gitignore not found, run ${PROGRAM} ls to list files"
    fi
    cp "${REPOSITORY}/$1.gitignore" ./.gitignore
esac
