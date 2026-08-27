#!/usr/bin/env python3
import os
import sys
import tempfile
import unittest

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from sample_cangjie_test import select


def _touch(path):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "w"):
        pass


class TestSelect(unittest.TestCase):
    def setUp(self):
        self.root = tempfile.mkdtemp()
        r = self.root
        # Full-syntax dir: all .cj taken verbatim.
        _touch(os.path.join(r, "HLT/API/syntax/a.cj"))
        _touch(os.path.join(r, "HLT/API/syntax/sub/b.cj"))
        # Stratum HLT/compiler: 10 files -> 5% = 0 -> max(1,0) = 1 sample.
        for i in range(10):
            _touch(os.path.join(r, "HLT/compiler/f%d.cj" % i))
        # Stratum LLT/compiler: 40 files -> 5% = 2 samples.
        for i in range(40):
            _touch(os.path.join(r, "LLT/compiler/g%d.cj" % i))
        # Non-.cj is ignored.
        _touch(os.path.join(r, "HLT/compiler/ignore.txt"))
        # Unknown top-level dir is ignored.
        _touch(os.path.join(r, "Other/x.cj"))

    def test_full_dir_files_all_selected(self):
        sel = select(self.root)
        self.assertIn("HLT/API/syntax/a.cj", sel)
        self.assertIn("HLT/API/syntax/sub/b.cj", sel)

    def test_stratum_sample_size_min_one(self):
        sel = select(self.root, rate=0.05, cap=300)
        hlt = [p for p in sel if p.startswith("HLT/compiler/")]
        llt = [p for p in sel if p.startswith("LLT/compiler/")]
        self.assertEqual(len(hlt), 1)   # 10*0.05=0 -> max(1)=1
        self.assertEqual(len(llt), 2)   # 40*0.05=2

    def test_cap_applied(self):
        # rate high enough that cap binds: 10 files, cap=3 -> 3
        sel = select(self.root, rate=1.0, cap=3)
        hlt = [p for p in sel if p.startswith("HLT/compiler/")]
        self.assertEqual(len(hlt), 3)

    def test_deterministic_with_seed(self):
        a = select(self.root, seed=42)
        b = select(self.root, seed=42)
        self.assertEqual(a, b)
        c = select(self.root, seed=7)
        self.assertNotEqual(a, c)

    def test_non_cj_ignored(self):
        sel = select(self.root)
        self.assertFalse(any(p.endswith(".txt") for p in sel))

    def test_unknown_dirs_ignored(self):
        sel = select(self.root)
        self.assertFalse(any(p.startswith("Other/") for p in sel))


if __name__ == "__main__":
    unittest.main()
