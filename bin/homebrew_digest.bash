#!/usr/bin/env bash
# Generate the digest of a tar archive from its URL.

PROGRAM="$(basename "$0")"

case "$1" in
  "" | -h)
    printf "usage:\t%s [-h] url\n" "${PROGRAM}"
    ;;
  *)
    curl -Ls "$1" | shasum -a 256
    ;;
esac
