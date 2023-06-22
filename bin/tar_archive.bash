#!/usr/bin/env bash
# Creates a tape archive with zstd compression.

PROG="$(basename "$0")"

if [[ "$#" -ne 1 ]];then
  printf "usage:\t%s <file>\n" "${PROG}"
  exit 1
fi

FILE="$1"
if [[ -e "${FILE}" ]]; then
  tar --use-compress-program "zstd --threads=0" \
    --create --file "${FILE}.tar.zst" "${FILENAME}"
else
  printf "%s: no such file or directory: %s\n" "${PROG}" "${FILE}"
  exit 1
fi
