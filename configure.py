#!/usr/bin/env python3
"""Create and remove symbolic links for configuration files."""

import shutil
import subprocess
import sys
from argparse import ArgumentParser
from pathlib import Path

HOME = Path.home()

agents = [
    HOME / "conf.d" / "opt" / "dev.tshaka.remap.plist",
]

static_executables = [
    ("can", ["make"]),
    ("markdown_to_html", ["go",  "build", "-o", "../markdown_to_html.exe", "."]),
]


def build_executables():
    executables = HOME / "conf.d" / "bin"
    for program, build in static_executables:
        subprocess.run(build, check = True, cwd = executables / program)


def link_executables():
    target_directory = HOME / "bin"
    target_directory.mkdir(exist_ok = True)
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
        for source in config_backup.iterdir():
            target = config / source.stem
            shutil.move(source, target)
        if config_backup.is_symlink():
            config_backup.unlink()
        elif config_backup.is_dir():
            config_backup.rmdir()
        else:
            raise ValueError(f"{config_backup} is not a directory or symbolic link")


def load_launch_agents():
    if sys.platform == "darwin":
        target_directory = HOME / "Library" / "LaunchAgents"
        for agent in agents:
            shutil.copy(agent, target_directory)
            target = (target_directory / agent.stem).as_posix()
            subprocess.run(["launchctl", "load", target], check = True)


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


def unload_launch_agents():
    if sys.platform == "darwin":
        target_directory = HOME / "Library" / "LaunchAgents"
        for agent in agents:
            if agent.exists():
                target = target_directory / agent.stem
                subprocess.run(["launchctl", "unload", target.as_posix()], check = True)
                target.unlink()


def main():
    parser = ArgumentParser(prog = "configure", description = "configure current system")
    parser.add_argument("-b", "--build", action = "store_true", help = "build static executables")
    parser.add_argument("-i", "--uninstall", action = "store_true", help = "install configuration files")
    parser.add_argument("-u", "--install", action = "store_true", help = "uninstall configuration files")
    arguments = parser.parse_args()

    if arguments.build:
        build_executables()
    elif arguments.install:
        build_executables()
        link_executables()
        link_configuration_files()
    elif arguments.uninstall:
        unlink_executables()
        unlink_configuration_files()
    else:
        parser.print_help(file = sys.stderr)
        return 2


if __name__ == "__main__":
    sys.exit(main())
