#!/usr/bin/env bash
# Contains logic for creating and removing symbolic links for
# configuration files.

BIN="${HOME}/bin"
PROG="$(basename "$0")"
DIR="${HOME}/conf.d"

usage() {
  printf "usage:\t%s [-hiu]\n" "${PROG}"
}

if [[ "$#" -gt 1 ]]; then
  printf "%s: invalid number of arguments\n" "${PROG}" >&2
  usage
  exit 1
fi

case "$1" in
  "" | -h)
    usage
    exit
    ;;
  -i)
    for src in ${DIR}/bin/*; do
      if [[ ! -d "${src}" ]]; then
        dst="$(echo "${src}" | rg '\.\w+$' --replace '' | sed 's/conf.d\///')"
        chmod +x "${src}"
        ln -sf "${src}" "${dst}"
      fi
    done

    find "${DIR}/etc" -name ".*" -maxdepth 1 | while read src; do
      dst="$(echo "${src}" | sed 's/conf.d\/etc\///')"
      ln -sf "${src}" "${dst}"
    done
    ;;
  -u)
    for src in ${DIR}/bin/*; do
      if [[ ! -d "${src}" ]]; then
        link="$(echo "${src}" | rg '\.\w+$' --replace '' | sed 's/conf.d\///')"
        if [[ -e "${link}" ]]; then
          unlink "${link}"
        fi
      fi
    done

    find "${DIR}/etc" -name ".*" -maxdepth 1 | while read src; do
      link="$(echo "${src}" | sed 's/conf.d\/etc\///')"
      if [[ -e "${link}" ]]; then
        unlink "${link}"
      fi
    done
    ;;
  *)
    printf "%s: unrecognised option: %s\n" "${PROG}" "$1" >&2
    usage
    exit 1
    ;;
esac
