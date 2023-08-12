#!/usr/bin/env bash
# Instructs Git to ignore changes in the given file(s).

readonly PROGRAM="$(basename "$0")"

if [[ "$#" -eq 0 ]]; then
  printf "usage:\t%s file...\n" "${PROGRAM}"
  exit
fi

git update-index --assume-unchanged "$@"
git update-index --skip-worktree
