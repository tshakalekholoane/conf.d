#!/usr/bin/env bash
# Creates a tape archive with zstd compression.

PROG="$(basename "$0")"

usage=$(cat << _EOF_
usage: $PROG\t[-h]
\t\t<file> [-r]\n
_EOF_
)

case "$1" in
  "" | -h)
    printf "${usage}"
    ;;
  *)
    file="$1"
    if [[ ! -e "${file}" ]]; then
      printf "%s: no such file or directory: %s\n" "${PROG}" "${file}"
      exit 1
    fi

    if [[ "$2" == "-r" ]]; then
      optimise_ratio="--options zstd:compression-level=22"
    fi
    tar --zstd ${optimise_ratio} --create --file "${file}.tar.zst" "${file}"
esac
