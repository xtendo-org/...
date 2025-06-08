#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.12"
# dependencies = []
# ///

import datetime
import os
import sys
import subprocess


def main(title: str):
    today = datetime.date.today()
    home = os.path.expanduser("~")
    text_human_dir = f"{home}/text/human"

    original_cwd = os.getcwd()

    try:
        os.chdir(text_human_dir)

        month_dir = f"journal/{today.year}/{today.month:02d}"

        os.makedirs(month_dir, exist_ok=True)

        full_path = f"{month_dir}/{today.isoformat()}-{title}"

        result = subprocess.run(["nvim", full_path])
        sys.exit(result.returncode)

    finally:
        os.chdir(original_cwd)


if __name__ == "__main__":
    title = sys.argv[1]
    main(title)
