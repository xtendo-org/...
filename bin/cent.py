#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.12"
# dependencies = []
# ///

import base64
import enum
import os
import shutil
import sys
from pathlib import Path

HOME = os.path.expanduser("~")
CENTRAL_BUILD_CACHE = f"{HOME}/nodatacow/buildcache"


class ProjectType(enum.Enum):
    Stack = enum.auto()
    Pyproject = enum.auto()
    Cargo = enum.auto()
    NodeModules = enum.auto()


def build_cache_dirs(ptype: ProjectType) -> list[str]:
    match ptype:
        case ProjectType.Stack:
            return [".stack-work", "dist-newstyle"]
        case ProjectType.Pyproject:
            return [".venv"]
        case ProjectType.Cargo:
            return ["target", "output"]
        case ProjectType.NodeModules:
            return ["node_modules"]

def determine_project_type() -> ProjectType:
    if os.path.isfile("stack.yaml"):
        return ProjectType.Stack
    if os.path.isfile("pyproject.toml"):
        return ProjectType.Pyproject
    if os.path.isfile("Cargo.toml"):
        return ProjectType.Cargo
    if os.path.isdir("node_modules"):
        return ProjectType.NodeModules

    realpath = Path(".").resolve()
    if os.path.isfile(f"{realpath.name}.cabal"):
        return ProjectType.Stack

    print("Sorry, could not determine the project type.")
    sys.exit(-1)


def main():
    wd = os.getcwd()
    if not wd.startswith(HOME):
        print("Sorry, this script only works for directories under $HOME.")
        sys.exit(-1)

    project_type = determine_project_type()

    wd_rel = wd[len(HOME) + 1 :]
    wd_b64 = base64.urlsafe_b64encode(wd_rel.encode()).decode()

    print(f"Project type is {project_type.name}")
    print(f"Identifying the project directory as: {wd_rel} ({wd_b64})")
    project_build_cache = f"{CENTRAL_BUILD_CACHE}/{wd_b64}"

    os.makedirs(project_build_cache, exist_ok=True)
    for d in build_cache_dirs(project_type):
        abs_path = f"{wd}/{d}"
        new_location = f"{project_build_cache}/{d}"
        if os.path.exists(d):
            if os.path.islink(d):
                print(f"./{d} is already a link")
                continue
            print(f"Moving ./{d}")
            _ = shutil.move(abs_path, new_location)
        else:
            print(f"Making directory for ./{d} at {abs_path}")
            os.mkdir(new_location)
        print(f"Making symlink at ./{d} that points to {abs_path}")
        os.symlink(new_location, d)


if __name__ == "__main__":
    main()
