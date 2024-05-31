#!/usr/bin/env bash
# Generate the digest of a tar archive from its URL and copy it to the
# clipboard.

readonly PROGRAM="$(basename "$0")"

if [[ "$(uname)" != "Darwin" ]]; then
  printf "%s: incompatible system\n" "${PROGRAM}"
  exit 1
fi

case "$1" in
  "" | -h)
    printf "usage: %s [-h] url\n" "${PROGRAM}"
    ;;
  *)
    curl -Ls "$1" | shasum --algorithm 256 | cut -d ' ' -f1
    ;;
esac
