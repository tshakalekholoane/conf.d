#!/usr/bin/env python3
"""Generates a licence file specified in the current directory."""
import os
import sys
from datetime import datetime

DIRECTORY = os.path.join(os.environ["HOME"], "conf.d", "bin", "x_licence.d")
PROGRAM = os.path.basename(sys.argv[0])

files = {"isc": "isc.txt"}


def print_usage():
    print(f"usage:\t{PROGRAM} [-hl|<licence>]")


def list_licences():
    print("\n".join(files.keys()))


def main():
    if len(sys.argv) < 2:
        print_usage()
        return

    option = sys.argv[1]
    match option:
        case "-h":
            print_usage()
        case "-l":
            list_licences()
        case licence if licence in files:
            template = files[licence]
            template_path = os.path.join(DIRECTORY, template)
            if not os.path.exists(template_path):
                print(f"{PROGRAM}: entry not found: {licence}", file=sys.stderr)
                return
            with open(template_path, "r") as file:
                format_string = file.read()
            current_year = datetime.now().year
            author_name = "Tshaka Lekholoane"
            licence_text = format_string % (current_year, author_name)
            with open("LICENCE", "w") as licence_file:
                licence_file.write(licence_text)
        case _:
            print_usage()


if __name__ == "__main__":
    main()
