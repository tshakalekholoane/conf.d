#!/usr/bin/env bash
# Update the default GRUB entry.

readonly PROGRAM="$(basename "$0")"

source "${HOME}/conf.d/bin/include/log.bash"

log::set_prefix "${PROGRAM}: "

if [[ "$(uname)" != "Linux" ]]; then
  log::fatalf "incompatible operating system\n"
fi

if ! [[ "$#" -eq 1 && "$1" =~ ^[1-9][0-9]*$ ]]; then
  printf "usage: ${PROGRAM} index\n"
  exit 1
fi

sudo sed --in-place 's/^GRUB_DEFAULT=.*/GRUB_DEFAULT='"$1"'/' /etc/default/grub
sudo grub2-mkconfig --output /etc/grub2-efi.cfg
