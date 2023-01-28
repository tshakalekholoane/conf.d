#!/usr/bin/env bash
# Installs packages on macOS using a Brewfile.

PROG="$(basename "$0")"
BREWFILE="$HOME/conf.d/bin/$PROG.d/Brewfile"
BREW=$(which brew)

case "$1" in
  "" | "-h")
    printf "usage:\t%s\t[-hi]\n" $PROG
    exit
    ;;
  "-i")
    if [[ ! -e "$BREW" ]]; then
      printf "%s: package manager not found\n" $PROG >&2
      read -p "Do you want to install Homebrew? [y/N] "
      case $REPLY in
        "y" | "Y")
          curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
          ;;
        "n" | "N")
          exit 1
          ;;
      esac
    fi

    if [[ ! -e "$BREWFILE" ]]; then
      printf "%s: brew bundle file not found: %s\n" $PROG $BREWFILE >&2
      exit 1
    fi

    brew bundle install --file="$BREWFILE"
    ;;
  *)
    printf "%s: unrecognised option: %s" $PROG $1 >&2
    exit 1
esac
