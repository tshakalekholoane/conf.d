#!/usr/bin/env bash
# Instructs Git to ignore changes in the given file(s).

if [[ "$#" -eq 0 ]]; then
  printf "usage: %s file...\n" "$(basename "$0")"
  exit
fi

git update-index --assume-unchanged "$@"
git update-index --skip-worktree
