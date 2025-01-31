#!/usr/bin/env python

from dataclasses import dataclass, field
import os
import sys
from pathlib import Path


_PREFIX_LEN = len("/sys/class/")


def clip(path: str) -> str:
    return path[_PREFIX_LEN:]


def print_content(path: str) -> None:
    try:
        content = Path(path).read_text().rstrip()
    except OSError:
        print(f"{clip(path)} (OS blocked)")
    except UnicodeDecodeError:
        print(f"{clip(path)} (not decodable)")
    else:
        first_line, delimiter, _ = content.partition("\n")
        print(
            f"\033[31m{clip(path)}\033[0m: "
            + f"\033[34m{first_line}\033[0m{'...' if delimiter else ''}"
        )


@dataclass
class Recursor:
    inode_seen: set[int] = field(default_factory=set)

    def recurse(self, path: str, depth: int):
        realpath = os.path.realpath(path)
        stat = os.stat(realpath)
        if stat.st_ino in self.inode_seen:
            return

        else:
            self.inode_seen.add(stat.st_ino)

        for entry in os.scandir(path):
            if entry.is_dir():
                print(clip(entry.path), "[dir]")
                if entry.name == 'subsystem':
                    continue
                if depth < 10:
                    self.recurse(entry.path, depth + 1)
            else:
                print_content(entry.path)


if __name__ == "__main__":
    print("entering main")
    recursor = Recursor()
    recursor.recurse(f"/sys/class/{sys.argv[1]}", 0)
    print("exiting main")
