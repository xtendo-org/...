#!/usr/bin/env python
from pynput.keyboard import Key, KeyCode, Listener

_COUNTER = 0


def on_press(key: Key | KeyCode | None) -> None:
    try:
        print(f"Alphanumeric key pressed: {key.char}")
    except AttributeError:
        print(f"Special key pressed: {key}")


def on_release(key: Key | KeyCode | None) -> None:
    print(f"Key released: {key}")
    if key == Key.esc:
        # Stop listener
        raise ValueError("ESC")

    global _COUNTER
    _COUNTER += 1
    if 10 <= _COUNTER:
        raise ValueError(f"{_COUNTER=}")


# Collect events until released
with Listener(on_press=on_press, on_release=on_release) as listener:
    try:
    listener.join()
