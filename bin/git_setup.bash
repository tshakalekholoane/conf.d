#!/usr/bin/env bash
# Configures Git.

git config --global core.editor "$(which nvim)"
git config --global init.defaultBranch main
git config --global user.email "mail+git@tshaka.dev"
git config --global user.name "Tshaka Lekholoane"
