#!/usr/bin/env bash
# Purges Git commit history from a repository.

read -p "Are you sure? [y/N] "
case "${REPLY}" in
  y | Y)
    BRANCH="$(git branch --show-current)"
    git checkout --orphan latest
    git add --all
    git commit --all --message="init: initial commit"
    git branch --delete --force "${BRANCH}"
    git branch --move "${BRANCH}"
    git gc --aggressive --prune=all
    ;;
esac
