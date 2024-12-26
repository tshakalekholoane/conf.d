#!/usr/bin/env bash
# Remaps the following keys on macOS:
#
# - Right Alt -> Right Ctrl
# - Esc       -> Caps Lock
# - Caps Lock -> Esc
#
# See the following [1] for reference.
#
# [1]: https://tshaka.dev/a/jb3j7x

read -d '' mapping << _EOF_
{
  "UserKeyMapping": [
    {
      "HIDKeyboardModifierMappingSrc": 0x7000000e6,
      "HIDKeyboardModifierMappingDst": 0x7000000e4,
    },
    {
      "HIDKeyboardModifierMappingSrc": 0x700000029,
      "HIDKeyboardModifierMappingDst": 0x700000039,
    },
    {
      "HIDKeyboardModifierMappingSrc": 0x700000039,
      "HIDKeyboardModifierMappingDst": 0x700000029,
    },
  ]
}
_EOF_
hidutil property --set "${mapping}"
