#!/usr/bin/env bash
# Creates a new Go project.

PROG="$(basename "$0")"

usage() {
  printf "usage:\t%s <module> [-hl]\n" "${PROG}"
}

if [[ "$#" -eq 0 ]]; then
  usage
  exit
fi

PKG="$(echo "$1" | rg --only-matching '\w+$')"
MOD="$1"

module() {
  mkdir "${PKG}" && cd "${PKG}"
  go mod init "${MOD}"
  go work use . 2> /dev/null
}

case "$2" in
  "")
    module
    cat > main.go << _EOF_
package main

import "fmt"

func main() {
  fmt.Println("WUS GOOD?")
}
_EOF_
    ;;
  -h)
    usage
    exit
    ;;
  -l)
    module
    cat > "${PKG}.go" << _EOF_
package $PKG

func Add(a, b int) int { return a + b }
_EOF_
    cat > "${PKG}_test.go" << _EOF_
package $PKG

import "testing"

func TestAdd(t *testing.T) {
	tests := []struct {
		inputA, inputB, want int
	}{
		{2, 2, 4},
	}

	for _, test := range tests {
		t.Run("", func(t *testing.T) {
			got := Add(test.inputA, test.inputB)
			if got != test.want {
				t.Errorf("Add(%d, %d) = %d, want %d", test.inputA, test.inputB, got, test.want)
			}
		})
	}
}
_EOF_
  ;;
  *)
    usage
    exit 1
    ;;
esac

if [[ ! "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = "true" ]]; then
  git init
fi
