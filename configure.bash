#!/usr/bin/env bash
# Create and remove symbolic links for configuration files.

readonly PROGRAM="$(basename "$0")"

usage() {
  printf "usage:\t%s {help,install,uninstall}\n" "${PROGRAM}"
}

if [[ "$#" -gt 1 ]]; then
  printf "%s: invalid number of arguments\n" "${PROGRAM}" >&2
  usage
  exit 1
fi

case "$1" in
  "" | help)
    usage
    ;;
  install)
    printf "%s: linking wallpapers\n" "${PROGRAM}"
    if [[ ! -d "${HOME}/bg" ]]; then
      mkdir "${HOME}"/bg
    fi
    for target in "${HOME}"conf.d/bg/*; do
      destination=$(basename "${target}")
      destination="${HOME}/bg/${destination}"
      ln -sf "${target}" "${destination}"
    done

    printf "%s: linking executables\n" "${PROGRAM}"
    if [[ ! -d "${HOME}/bin" ]]; then
      mkdir "${HOME}/bin"
    fi
    for target in "${HOME}"/conf.d/bin/*; do
      if [[ ! -d "${target}" ]]; then
        filename=$(basename "${target}")
        filename="${filename%.*}"
        destination="${HOME}/bin/${filename}"
        chmod +x "${target}"
        ln -sf "${target}" "${destination}"
      fi
    done

    printf "%s: linking configuration files\n" "${PROGRAM}"
    if [[ -d "${HOME}/.config" ]]; then
      mv "${HOME}/.config" "${HOME}/.config~"
    fi
    find "${HOME}/conf.d/etc" -maxdepth 1 -name ".*" | while read target; do
      destination=$(basename "${target}")
      destination="${HOME}/${destination}"
      ln -sf "${target}" "${destination}"
    done

    if [[ -d "${HOME}"/.config~ ]]; then
      # Enable wildcard patterns such as `*`.
      shopt -s dotglob
      mv "${HOME}"/.config~/* "${HOME}"/.config/
      rmdir "${HOME}"/.config~
    fi
    ;;
  uninstall)
    printf "%s: unlinking executables\n" "${PROGRAM}"
    for target in "${HOME}"/conf.d/bin/*; do
      if [[ ! -d "${target}" ]]; then
        filename=$(basename "${target}")
        filename="${filename%.*}"
        if [[ -e "${filename}" ]]; then
          unlink "${filename}"
        fi
      fi
    done

    printf "%s: unlinking configuration files\n" "${PROGRAM}"
    find "${HOME}"/conf.d/etc -maxdepth 1 -name ".*" | while read target; do
      destination=$(basename "${target}")
      destination="${HOME}/${destination}"
      if [[ -e "${destination}" ]]; then
        unlink "${destination}"
      fi
    done
    ;;
  *)
    printf "%s: unrecognised option: %s\n" "${PROGRAM}" "$1" >&2
    usage
    exit 1
    ;;
esac
