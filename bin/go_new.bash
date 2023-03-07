#!/usr/bin/env bash
# Creates a new Go project.

set -e

PROG="$(basename "$0")"

if [[ "$#" -eq 0 ]]; then
  printf "usage:\t%s <module>\n" "${PROG}"
  exit
fi

PKG="$(echo "$1" | rg --only-matching '\w+$')"
mkdir "${PKG}" && cd "${PKG}"
go mod init "$1"
cat > main.go << _EOF_
package main

import "fmt"

func main() {
  fmt.Println("WUS GOOD?")
}
_EOF_
git init
