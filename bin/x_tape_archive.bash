#!/usr/bin/env bash
# Creates a tape archive with zstd compression.

PROGRAM="$(basename "$0")"

case "$1" in
  "" | -h)
    printf "usage:\t%s\t[-h]\n\t\t\t\t<file> [-r]\n" "${PROGRAM}"
    ;;
  *)
    FILE="$1"
    if [[ ! -e "${FILE}" ]]; then
      printf "%s: no such file or directory: %s\n" "${PROGRAM}" "${FILE}"
      exit 1
    fi
    if [[ "$2" == "-r" ]]; then
      OPTIMISE="--options zstd:compression-level=22"
    fi
    tar --zstd ${OPTIMISE} --create --file "${FILE}.tar.zst" "${FILE}"
esac
