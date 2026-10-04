#!/usr/bin/env python3
import os
import signal
import subprocess
import sys
import tempfile
import time

BARS = 6
CHARS = [" ", " ", "▂", "▃", "▄", "▅", "▆", "▇", "█"]

conf_text = f"""
[general]
bars = {BARS}
framerate = 25

[input]
method = pulse
source = auto

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7
"""

with tempfile.NamedTemporaryFile("w", delete=False) as f:
    f.write(conf_text)
    conf_path = f.name


def cleanup(*args):
    try:
        os.remove(conf_path)
    except OSError:
        pass
    sys.exit(0)


signal.signal(signal.SIGINT, cleanup)
signal.signal(signal.SIGTERM, cleanup)

proc = subprocess.Popen(["cava", "-p", conf_path], stdout=subprocess.PIPE, text=True)

silent_count = 0
was_silent = True

try:
    for line in proc.stdout:
        vals = [int(x) for x in line.strip().split(";") if x.isdigit()]
        if not vals:
            continue

        if all(v == 0 for v in vals):
            silent_count += 1
            if silent_count >= 15:
                if not was_silent:
                    print("", flush=True)
                    was_silent = True
            continue

        silent_count = 0
        was_silent = False
        bar_str = "".join(CHARS[min(v, len(CHARS) - 1)] for v in vals)
        print(bar_str, flush=True)
except (BrokenPipeError, KeyboardInterrupt):
    pass
finally:
    proc.terminate()
    cleanup()
