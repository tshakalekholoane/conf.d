#!/usr/bin/env bash
# Update the default GRUB entry.

if [[ "$(uname -s)" != "Linux" ]]; then
  printf "%s: incompatible system\n" "$(basename "$0")" >&2
  exit 1
fi

if ! [[ "$#" -eq 1 && "$1" =~ ^[1-9][0-9]*$ ]]; then
  printf "usage: %s index\n" "$(basename "$0")" >&2
  exit 1
fi

sudo sed --in-place 's/^GRUB_DEFAULT=.*/GRUB_DEFAULT='"$1"'/' /etc/default/grub
sudo grub2-mkconfig --output /etc/grub2-efi.cfg
