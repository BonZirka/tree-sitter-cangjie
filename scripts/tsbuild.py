#!/usr/bin/env python3
"""Regenerate src/parser.c from grammar.js and build the Neovim parser .so.

Usage: python3 scripts/tsbuild.py [--out PATH] [--quiet]
"""
import argparse
import os
import subprocess
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
TS = os.path.expanduser("~/.cargo/bin/tree-sitter")
DEFAULT_OUT = os.path.expanduser("~/.local/share/nvim/site/parser/cangjie.so")

QUERIES_OUT = os.path.expanduser("~/.local/share/nvim/site/queries/cangjie/")

def run(cmd: list[str]) -> str:
    r = subprocess.run(cmd, cwd=ROOT, capture_output=True, text=True)
    if r.returncode != 0:
        sys.stderr.write(r.stdout)
        sys.stderr.write(r.stderr)
        sys.exit(r.returncode)
    return r.stdout + r.stderr


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--out", default=DEFAULT_OUT)
    ap.add_argument("--quiet", action="store_true", help="suppress generate warnings")
    args = ap.parse_args()

    out = run([TS, "generate"])
    # if not args.quiet and out.strip():
    #     print(out.strip())

    run([
        "gcc", "-shared", "-fPIC", "-std=c11",
        f"-I{os.path.join(ROOT, 'src')}",
        os.path.join(ROOT, "src", "parser.c"),
        os.path.join(ROOT, "src", "scanner.c"),
        "-o", args.out,
    ])
    print(f"OK -> {args.out}")
    import shutil
    src = os.path.join(ROOT, "queries")
    dst = QUERIES_OUT
    shutil.copytree(src, dst, dirs_exist_ok=True)
    print(f"{src} -> {dst}")
    ft_src = os.path.join(ROOT, "ftdetect", "cangjie.vim")
    # QUERIES_OUT = <site>/queries/cangjie/  ->  ftdetect lives at <site>/ftdetect
    site_dir = os.path.dirname(os.path.dirname(QUERIES_OUT.rstrip("/")))
    ft_dst_dir = os.path.join(site_dir, "ftdetect")
    os.makedirs(ft_dst_dir, exist_ok=True)
    shutil.copy2(ft_src, os.path.join(ft_dst_dir, "cangjie.vim"))
    print(f"{ft_src} -> {ft_dst_dir}")
    exit(0)


if __name__ == "__main__":
    main()
