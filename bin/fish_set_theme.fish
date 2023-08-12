#!/usr/bin/env fish
# Sets the shell theme.

set program (basename (status filename))

function usage -d "Prints usage information to standard output."
  printf "usage:\t%s {dark,light}\n" "$program"
end

function main
  if test (count $argv) -eq 0
    usage
    exit
  end
  switch "$argv[1]"
  case dark light
    set colour_scheme (printf "Gruvbox %s Soft" (echo "$argv[1]" | tr 'dl' 'DL'))
    fish_config theme choose "$colour_scheme"
  case "*"
    printf "%s: unrecognised option: %s\n" "$program" "$argv[1]" >&2
    usage >&2
    exit 1
  end
end

main $argv
