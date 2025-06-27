#!/usr/bin/env bash
# Disables Grub's timed display.

source "${HOME}/rc.d/bin/include/log.bash"

if [[ "$(uname)" != "Linux" ]]; then
  log::set_prefix "$(basename "$0"): "
  log::fatalf "incompatible operating system\n"
fi
sudo sed --in-place 's/^GRUB_TIMEOUT=[0-9]\+/GRUB_TIMEOUT=-1/' /etc/default/grub
sudo grub2-mkconfig -o /etc/grub2-efi.cfg
