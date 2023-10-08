#!/usr/bin/env python
import re
import os
import sys

from datetime import timedelta
from pathlib import Path

#
# CLI args
#
file_path = sys.argv[1]     # path to input video
out_path = sys.argv[2]      # path for output images
snaps = int(sys.argv[3])    # number of snaps
start = int(sys.argv[4])    # start time in milliseconds

file_stem = Path(file_path).stem

if not os.path.isdir(out_path):
    os.system(f'mkdir {out_path}')

in_file = f'-i {file_path}'
opts = '-frames:v 1 -q:v 1 -hide_banner -loglevel error'

for snap in range(snaps):
    elapsed = start + snap
    snap_time = str(timedelta(milliseconds=elapsed))[:-3]
    out_file = f'{out_path}/ff_{file_stem}_{str(elapsed)}_.jpg'
    ff_cmd = f'ffmpeg -ss {snap_time} -i {file_path} {opts} -y {out_file}'
    print(ff_cmd)
    os.system(ff_cmd)
