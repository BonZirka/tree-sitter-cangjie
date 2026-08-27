#!/usr/bin/env python3
"""Reproducible stratified sampler for the cangjie_test corpus.

Selects which `.cj` files to vendor into test/sources/cangjie_test/:

* Full — every `.cj` under SYNTAX_FULL_DIRS (syntax-focused, ~3.5k files).
* Sampled — RATE of each top-level stratum, capped at CAP, drawn with a
  fixed SEED so the manifest is reproducible across runs.

Emits the manifest (one selected path per line, relative to the testsuites
root) to stdout. --output writes to a file; --vendor DIR copies the selected
files into DIR, preserving their testsuites/... relative paths.
"""
import argparse
import os
import random
import shutil
import sys

DEFAULT_ROOT = os.path.expanduser("~/newrepos/main/cangjie_test/testsuites")

# Directories under testsuites/ taken in full (every .cj file).
SYNTAX_FULL_DIRS = [
    "HLT/API/syntax",
    "HLT/regression",
    "LLT/compiler/Parser",
    "LLT/compiler/Lexer",
    "LLT/compiler/Diagnose",
]

# Top-level strata (testsuites/<stratum>) sampled at RATE, capped at CAP.
STRATA = [
    "HLT/compiler",
    "LLT/compiler",
    "HLT/Tools",
    "HLT/API",
    "LLT/Tools",
    "LLT/API",
    "HLT/Runtime",
    "LLT/Runtime",
]

SEED = 42
RATE = 0.05
CAP = 300


def _is_full(rel, full_dirs):
    """True if rel (POSIX, relative to testsuites root) is under a full dir."""
    for d in full_dirs:
        if rel == d or rel.startswith(d + "/"):
            return True
    return False


def _stratum_of(rel, strata):
    """Return the matching stratum prefix (first two components) or None."""
    parts = rel.split("/")
    if len(parts) >= 2:
        prefix = "/".join(parts[:2])
        return prefix if prefix in strata else None
    return None


def select(root, seed=SEED, rate=RATE, cap=CAP,
           full_dirs=SYNTAX_FULL_DIRS, strata=STRATA):
    """Return sorted list of selected POSIX relpaths (relative to root).

    Combines the full-syntax set with a stratified sample of the remainder.
    """
    full = []
    by_stratum = {s: [] for s in strata}
    for dirpath, dirnames, filenames in os.walk(root):
        dirnames.sort()
        for fn in sorted(filenames):
            if not fn.endswith(".cj"):
                continue
            rel = os.path.relpath(
                os.path.join(dirpath, fn), root).replace(os.sep, "/")
            if _is_full(rel, full_dirs):
                full.append(rel)
            else:
                s = _stratum_of(rel, strata)
                if s is not None:
                    by_stratum[s].append(rel)
    rng = random.Random(seed)
    sampled = []
    for s in strata:
        pool = sorted(by_stratum[s])
        n = min(cap, max(1, int(len(pool) * rate))) if pool else 0
        sampled.extend(rng.sample(pool, n) if n else [])
    return sorted(set(full) | set(sampled))


def vendor(root, dest, selected):
    """Copy each selected rel path from root into dest, preserving structure."""
    copied = 0
    for rel in selected:
        src = os.path.join(root, rel)
        dst = os.path.join(dest, rel)
        os.makedirs(os.path.dirname(dst), exist_ok=True)
        shutil.copy2(src, dst)
        copied += 1
    return copied


def main(argv=None):
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--root", default=DEFAULT_ROOT,
                    help="testsuites root (default: %(default)s)")
    ap.add_argument("--output", default="-",
                    help="manifest output path, or '-' for stdout (default: stdout)")
    ap.add_argument("--vendor", metavar="DIR",
                    help="also copy selected files into DIR, preserving paths")
    ap.add_argument("--seed", type=int, default=SEED)
    ap.add_argument("--rate", type=float, default=RATE)
    ap.add_argument("--cap", type=int, default=CAP)
    args = ap.parse_args(argv)
    if not os.path.isdir(args.root):
        sys.exit("error: root not found: %s" % args.root)

    selected = select(args.root, args.seed, args.rate, args.cap)

    if args.vendor:
        if not os.path.isdir(args.vendor):
            os.makedirs(args.vendor, exist_ok=True)
        n = vendor(args.root, args.vendor, selected)
        print("vendored %d files into %s" % (n, args.vendor), file=sys.stderr)

    out = sys.stdout if args.output == "-" else open(args.output, "w")
    try:
        for rel in selected:
            out.write(rel + "\n")
    finally:
        if out is not sys.stdout:
            out.close()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
