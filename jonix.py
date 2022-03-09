#!/usr/bin/env python3.11

"""Script para testes."""

import subprocess

filename = "/home/jonix"

try:
    pids = subprocess.check_output(
        "lsof /home/jonix | tail -n +2 | awk '{print $1}'", shell=True, text=True
    ).splitlines()
    # pid = pids.split()
    # pid = pids.split()
    # for pid in pids.split():
    #    print(pid)
    # pid = re.findall(r'..c..', pids)
    print(pids)
except Exception as e:
    print(e)
