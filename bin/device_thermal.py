#!/usr/bin/env python

import os

_SYS_HWMON_PATH = "/sys/class/hwmon"


def sread(path: str):
    with open(path, "r") as f:
        return f.read()


def main():
    devs: list[str] = os.listdir(_SYS_HWMON_PATH)
    print(f"Looking at {len(devs)=}")
    for dev_name in sorted(devs):
        dev_path = f"{_SYS_HWMON_PATH}/{dev_name}"
        name_part: str = ''
        try:
            stored_name = sread(f"{dev_path}/name").rstrip()
        except Exception:
            pass
        else:
            name_part = f' \033[1m{stored_name}\033[0m'
        print(f"{dev_path}{name_part}")
        for sub_name in sorted(os.listdir(dev_path)):
            sub_path = f"{dev_path}/{sub_name}"
            try:
                content = sread(sub_path).rstrip()
            except Exception:
                continue
            content_lines = content.split("\n")
            if 1 < len(content_lines):
                print(f"    {sub_path}")
                for line in content_lines:
                    print(f"        {line}")
            else:
                print(f"    \033[31m{sub_name}\033[0m: \033[34m{content}\033[0m")


if __name__ == "__main__":
    print("entering main")
    main()
    print("exiting main")
