#!/usr/bin/env python3
"""Sets the background in Neovim instances via a socket."""
import glob
import sys
from argparse import ArgumentParser

import pynvim

parser = ArgumentParser(
    prog="nvim_set_background",
    description="Sets the background in Neovim via a socket.",
)

parser.add_argument("background", choices=["dark", "light"], help="colour scheme")

arguments = parser.parse_args()

sockets = glob.glob("/tmp/nvim-*")
if len(sockets) == 0:
    print(f"{parser.prog}: cannot find an active Neovim socket", file=sys.stderr)
    sys.exit(1)

instances = []
for socket in sockets:
    try:
        instance = pynvim.attach("socket", path=socket)
        instances.append(instance)
    except FileNotFoundError:
        print(f"{parser.prog}: socket not found: {socket}", file=sys.stderr)
        sys.exit(1)

for instance in instances:
    instance.command(f"set background={arguments.background}")
