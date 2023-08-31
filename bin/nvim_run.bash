#!/usr/bin/env bash
# Start Neovim with an RPC server listening on a socket which can be
# used to receive external commands i.e., system background changes.

readonly NVIM_LISTEN_ADDRESS=$(mktemp -u "/tmp/nvim-XX")
nvim --listen "${NVIM_LISTEN_ADDRESS}" "$@"
