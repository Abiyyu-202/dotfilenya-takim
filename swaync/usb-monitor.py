#!/usr/bin/env python3
import subprocess
import time
import os
import glob
import sys

# Cache of known USB devices: devpath -> friendly name
known_devices = {}
# Debounce tracking: devpath -> timestamp
last_notified = {}

def get_device_info(devpath):
    """Retrieve friendly name and attributes for a USB device path."""
    try:
        out = subprocess.check_output(
            ['udevadm', 'info', '-p', devpath, '--query=property'],
            text=True, stderr=subprocess.DEVNULL
        )
        props = dict(line.split('=', 1) for line in out.splitlines() if '=' in line)
        
        # Check if it's a root hub, skip
        if 'root_hub' in props.get('ID_MODEL', ''):
            return None
        if props.get('DEVTYPE') != 'usb_device':
            return None

        vendor = props.get('ID_VENDOR_FROM_DATABASE') or props.get('ID_VENDOR') or ''
        model = props.get('ID_MODEL_FROM_DATABASE') or props.get('ID_MODEL') or ''
        name = f"{vendor} {model}".strip().replace('_', ' ')

        if not name:
            syspath = os.path.join('/sys', devpath.lstrip('/'))
            mfg_f = os.path.join(syspath, 'manufacturer')
            prod_f = os.path.join(syspath, 'product')
            mfg = open(mfg_f).read().strip() if os.path.exists(mfg_f) else ''
            prod = open(prod_f).read().strip() if os.path.exists(prod_f) else ''
            name = f"{mfg} {prod}".strip()

        return name if name else "Perangkat USB"
    except Exception:
        return "Perangkat USB"

def init_known_devices():
    """Populate existing USB devices on startup."""
    for d in glob.glob('/sys/bus/usb/devices/*'):
        base = os.path.basename(d)
        # Skip root hubs (usb1, usb2) and interfaces (contain ':')
        if base.startswith('usb') or ':' in base:
            continue
        real_path = os.path.realpath(d)
        devpath = real_path.replace('/sys', '')
        name = get_device_info(devpath)
        if name:
            known_devices[devpath] = name

def notify_connect(name):
    # Play sound
    subprocess.Popen(['canberra-gtk-play', '-i', 'device-added'])
    # Send desktop notification
    subprocess.Popen([
        'notify-send',
        '-a', 'USB Monitor',
        '-i', 'drive-removable-media',
        '-u', 'normal',
        'USB Terhubung',
        name
    ])

def notify_disconnect(name):
    # Play sound
    subprocess.Popen(['canberra-gtk-play', '-i', 'device-removed'])
    # Send desktop notification
    subprocess.Popen([
        'notify-send',
        '-a', 'USB Monitor',
        '-i', 'drive-removable-media',
        '-u', 'normal',
        'USB Terputus',
        name
    ])

def main():
    init_known_devices()

    # Monitor udev events specifically for usb_device
    cmd = ['stdbuf', '-oL', 'udevadm', 'monitor', '--udev', '--subsystem-match=usb/usb_device']
    proc = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.DEVNULL, text=True, bufsize=1)

    for line in iter(proc.stdout.readline, ''):
        line = line.strip()
        if not line or not line.startswith('UDEV'):
            continue

        parts = line.split()
        if len(parts) < 4:
            continue

        action = parts[2]
        devpath = parts[3]

        # Ignore root hubs
        if devpath.endswith('/usb1') or devpath.endswith('/usb2') or devpath.endswith('/usb3'):
            continue

        now = time.time()

        if action in ('add', 'bind'):
            # Debounce within 2 seconds for same devpath
            if devpath in last_notified and (now - last_notified[devpath]) < 2.0:
                continue

            # Give udev a moment to finish populating properties
            time.sleep(0.4)
            name = get_device_info(devpath)
            if not name:
                continue

            known_devices[devpath] = name
            last_notified[devpath] = now
            notify_connect(name)

        elif action in ('remove', 'unbind'):
            if devpath in last_notified and (now - last_notified[devpath]) < 1.0:
                # Avoid duplicate disconnect events
                continue

            name = known_devices.pop(devpath, None)
            if name:
                last_notified[devpath] = now
                notify_disconnect(name)

if __name__ == '__main__':
    main()
