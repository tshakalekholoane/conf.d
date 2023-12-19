#!/usr/bin/env bash
# Prevents Grub's timed display.

if [[ "$(uname -s)" != "Linux" ]]; then
  printf "%s: incompatible system\n" "$(basename "$0")"
  exit 1
fi
sudo sed --in-place 's/^GRUB_TIMEOUT=[0-9]\+/GRUB_TIMEOUT=-1/' /etc/default/grub
sudo grub2-mkconfig -o /etc/grub2-efi.cfg
