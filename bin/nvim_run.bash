#!/usr/bin/env bash

IDENTIFIER="$(openssl rand -hex 4)"
NVIM_LISTEN_ADDRESS="/tmp/nvim-${IDENTIFIER}" nvim "$@"
