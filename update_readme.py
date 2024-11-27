#! /usr/bin/env python3
from pathlib import Path
import subprocess
import re

toml_text = Path("typst.toml").read_text()
groups = re.match(r".*version = \"(.*?)\"", toml_text, re.DOTALL)
assert groups
version = groups.group(1)

cmd = f"""
showman md \
    docs/readme.typ \
    --output README.md \
    --root_dir . \
    --assets_dir assets \
    --git_url https://www.github.com/ntjess/wrap-it/v{version}/ \
    # --log_level DEBUG
"""
print(" ".join(cmd.split()))
subprocess.run(cmd, check=True, shell=True)
