#!/usr/bin/env bash
# Purges Git commit history from a repository.

read -p "Are you sure? [y/N] "
case "${REPLY}" in
  y | Y)
    readonly CURRENT_BRANCH="$(git branch --show-current)"
    git checkout --orphan latest
    git add --all
    git commit --all --message="init: initial commit"
    git branch --delete --force "${CURRENT_BRANCH}"
    git branch --move "${CURRENT_BRANCH}"
    git gc --aggressive --prune=all
    ;;
esac
