#!/usr/bin/env bash
# Generates a configuration file for the language (formatter) specified
# in the current directory.

DIR="$HOME/conf.d/bin/x_fmt.d"
PROG="$(basename "$0")"

declare -A files 
files["rust"]="rustfmt.toml"
files["swift"]=".swiftformat"

case "$1" in
  "" | "-h")
    printf "usage:\t%s\t[-hl|language]\n" $PROG
    ;;
  "-l")
    printf "%s\n" ${!files[@]}
    ;;
  *)
    CFG="$(echo ${files["$1"]})"
    if [[ -z "$CFG" || ! -e "$DIR/$CFG" ]]; then
      printf "%s: entry not found: %s\n" $PROG $1 >&2
      exit 1
    fi
    cp "$DIR/$CFG" "$PWD"
    ;;
esac
