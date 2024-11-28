#! /usr/bin/env python3
import re
from pathlib import Path

from showman.converter import Converter

toml_text = Path("typst.toml").read_text()
groups = re.match(r".*version = \"(.*?)\"", toml_text, re.DOTALL)
assert groups
version = groups.group(1)


class WrapItConverter(Converter):
    def _setup_build_folder(self, persist=False):
        return (
            self.typst_file.parent,
            self.typst_file.parent / "make-example-images.typ",
        )

    def _get_runnable_langs(self):
        return ["example"]

    def __del__(self):
        # No need to clean up build directory
        pass


WrapItConverter(
    "docs/readme.typ",
    assets_dir="assets",
    root_dir=".",
    showable_labels=["example"],
    # log_level="DEBUG",
).save(
    out_path="README.md",
    remote_url=f"https://www.github.com/ntjess/wrap-it/v{version}/",
    force=True,
)
