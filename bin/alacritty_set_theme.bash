#!/usr/bin/env bash
# Sets the terminal theme.

readonly PROGRAM="$(basename "$0")"

usage() {
  printf "usage:\t%s {dark,light}\n" "${PROGRAM}"
}

main() {
  if [[ "$#" -eq 0 ]]; then
    usage
    exit
  fi

  case "$1" in
    dark | light)
      readonly CONFIGURATION="${HOME}/.config/alacritty/alacritty.yml"
      readonly CURRENT_THEME="$(rg 'themes' "${CONFIGURATION}" --no-line-number | sed -E "s|\"||g; s|^  - ~/|${HOME}/|g")"
      sed -E -i '' "s/\*(dark|light)\$/*$1/" "${CURRENT_THEME}"
      ;;
    *)
      printf "%s: unrecognised option: %s\n" "${PROGRAM}" "$1" >&2
      usage >&2
      exit 1
      ;;
  esac
}

main "$@"
