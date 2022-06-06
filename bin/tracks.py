#!/usr/bin/python

import os

files = os.listdir()

with open('tracks.txt') as f:
    tracks = f.read()

tracks = tracks.strip().split('\n')

for (i_0, title) in enumerate(tracks):
    i = i_0 + 1
    for j in range(len(files)):
        filename = files[j]
        if title in filename:
            new_filename = '{:02d}. '.format(i) + filename
            print(new_filename)
            os.rename(filename, new_filename)
            files.pop(j)
            break
    else:
        print('Warning: file not found for ' + title)
