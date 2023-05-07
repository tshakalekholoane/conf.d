#!/usr/bin/env bash
# Contains logic for creating and removing symbolic links for
# configuration files.

PROG="$(basename "$0")"

usage() {
  printf "usage:\t%s {help,install,uninstall}\n" "${PROG}"
}

if [[ "$#" -gt 1 ]]; then
  printf "%s: invalid number of arguments\n" "${PROG}" >&2
  usage
  exit 1
fi

case "$1" in
  "" | help)
    usage
    exit
    ;;
  install)
    if [[ ! -d ~/bin ]]; then
      mkdir ~/bin
    fi
    for src in ~/conf.d/bin/*; do
      if [[ ! -d "${src}" ]]; then
        dst="$(echo "${src}" | rg '\.\w+$' --replace '' | sed 's/conf.d\///')"
        chmod +x "${src}"
        ln -sf "${src}" "${dst}"
      fi
    done
    if [[ -d ~/.config ]]; then
      mv ~/.config ~/.config~
    fi
    find ~/conf.d/etc -maxdepth 1 -name ".*" | while read src; do
      dst="$(echo "${src}" | sed 's/conf.d\/etc\///')"
      ln -sf "${src}" "${dst}"
    done
    if [[ -d ~/.config~ ]]; then
      shopt -s dotglob
      mv ~/.config/* ~/.config/
      rmdir ~/.config~
    fi
    ;;
  uninstall)
    for src in ~/conf.d/bin/*; do
      if [[ ! -d "${src}" ]]; then
        link="$(echo "${src}" | rg '\.\w+$' --replace '' | sed 's/conf.d\///')"
        if [[ -e "${link}" ]]; then
          unlink "${link}"
        fi
      fi
    done
    find ~/conf.d/etc -maxdepth 1 -name ".*" | while read src; do
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
