#!/usr/bin/env python3
"""Create and remove symbolic links for configuration files."""

import shutil
import sys
from pathlib import Path


USAGE = "usage: configure [--help] {install, uninstall}"
HOME = Path.home()


def link_executables():
    target_directory = HOME / "bin"
    target_directory.mkdir(exist_ok=True)
    source_directory = HOME / "conf.d" / "bin"
    for source in source_directory.iterdir():
        if not source.is_dir():
            target = target_directory / source.stem
            try:
                target.symlink_to(source)
            except FileExistsError:
                pass


def link_configuration_files():
    restore_config = False
    config = HOME / ".config"
    config_backup = HOME / ".config~"
    if config.exists():
        shutil.move(config, config_backup)
        restore_config = True

    target_directory = HOME
    source_directory = HOME / "conf.d" / "etc"
    for source in source_directory.iterdir():
        target = target_directory / source.stem
        try:
            target.symlink_to(source)
        except FileExistsError:
            pass

    if restore_config:
        for file in config_backup.iterdir():
            source = config_backup / file
            target = config / file
            shutil.move(source, target)
        config_backup.unlink()


def unlink_executables():
    target_directory = HOME / "bin"
    if not target_directory.exists():
        return
    source_directory = HOME / "conf.d" / "bin"
    for source in source_directory.iterdir():
        if not source.is_dir():
            target = target_directory / source.stem
            if target.exists():
                target.unlink()


def unlink_configuration_files():
    target_directory = HOME
    source_directory = HOME / "conf.d" / "etc"
    for source in source_directory.iterdir():
        target = target_directory / source.stem
        if target.exists():
            target.unlink()


def main():
    if len(sys.argv) < 2:
        print(USAGE)
        return 1
    option = sys.argv[1]
    match option:
        case "-h" | "--help":
            print(USAGE)
        case "install":
            link_executables()
            link_configuration_files()
        case "uninstall":
            unlink_executables()
            unlink_configuration_files()
        case _:
            print(f"configure: unrecognised option: {option}")
            return 1


if __name__ == "__main__":
    sys.exit(main())
