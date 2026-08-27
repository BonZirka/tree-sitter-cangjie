#!/usr/bin/env python3
"""Coloring expectations for highlights.scm, verified against tree-sitter query output.

Each expectation is (capture-or-None, text, line-1-based). capture=None asserts the
text receives NO capture (bare expression identifier). Run: python3 scripts/highlight_expectations.py
"""
import re
import subprocess
import sys
import tempfile
import os

SRC = r"""// c
import std.math.* as M
@Deprecated
class Shape<T> <: Pane {
    let area: Float64 = 1.5
    prop size: Int64 {
        get() { 2 }
        set(v) { }
    }
    func scale<F, R>(k: F, v: Int64): Unit where F <: Number {
        let msg = "a\u{41}${3.14 + k}b"
        let ch = r'x'
        let by = b'\x00'
        let u = ()
        let t = true
        let n: VArray<Int64, $3> = VArray<Int64, $3>()
        let g = Foo<Bar>()
        let c = Int64(7)
        let l = Foo::make<T>()
        let m = obj.method(a)
        this.area = k ?? 1.5
        arr[0]++
        i *= 2
        match (ch) { case Red => () case C.Green => () case _ => () }
        for (e in 0..10) { }
        let q = quote(var $v = $(w.x) + (y))
    }
    init(name!: String) {}
    let wide: Int64 = 2
}
enum Color { Red | Green }
macro mk(x: Expr) { @body(1) }
"""

# (capture, locator[, occ[, text]]) — the capture must appear on the locator's
# line with text == text (default: the locator). capture None = must be bare.
EXPECT = [
    ("keyword", "import"), ("keyword", "class"), ("keyword", "let"),
    ("keyword", "prop"), ("keyword", "get"), ("keyword", "set"),
    ("keyword", "func"), ("keyword", "where"), ("keyword", "for"),
    ("keyword", "match"), ("keyword", "case"), ("keyword", "init"),
    ("keyword", "quote("),
    ("type", "Shape"), ("type", "Pane"), ("type", "T"),
    ("type", "F"), ("type", "Number"), ("type", "Bar"),
    ("type", "String"),
    ("function", "scale"), ("function", "make"), ("function", "method"),
    ("function.macro", "mk"), ("function.macro", "body"),
    ("function", "VArray<Int64, $3>()", 0, "VArray"),
    ("type.builtin", ": VArray<Int64", 0, "VArray"),
    ("type.builtin", "Float64"), ("type.builtin", "Int64", 1),
    ("type", "String"),
    ("variable", "area"), ("parameter", "k"), ("parameter", "v"),
    ("parameter", "name"),
    ("variable.builtin", "this"),
    ("constant.builtin", "true"), ("constant.builtin", "()", 1),
    ("constant", "Green"), ("variable", "Red", 0),
    ("number", "1.5", 1), ("number", "3.14"),
    ("string", "a"), ("string", "b"),
    ("string.escape", "\\u{41}"), ("character", "r'x'"), ("character", "b'\\x00'"),
    ("comment", "// c"),
    ("operator", "??"), ("operator", "++"), ("operator", "*="),
    ("operator", "=>"), ("operator", ".."), ("operator", "<:"),
    ("operator", "_"),
    ("punctuation.special", "${"), ("punctuation.special", "3.14 + k}b", 0, "}"),
    ("punctuation.special", "@"),
    ("variable.builtin", "$v", 0, "$"), ("variable.builtin", "$v", 0, "v"),
    ("variable.builtin", "w.x", 0, "$("),
    ("variable.builtin", "w.x", 0, ")"),
    ("module", "std.math", 0, "std.math.* as M"),
    ("property", "area", 1), ("property", "w.x", 0, "x"),
    # bare expression identifiers receive no capture at all
    (None, "ch", 1, "ch"), (None, "w.x", 0, "w"),
]

def run_query(path):
    out = subprocess.run(["tree-sitter", "query", "queries/highlights.scm", path],
                         capture_output=True, text=True, timeout=30)
    if out.returncode != 0:
        print(out.stderr)
        sys.exit(1)
    caps = []
    for m in re.finditer(r"capture: \d+ - (\S+), start: \((\d+), (\d+)\), end: \((\d+), (\d+)\), text: `([^`]*)`", out.stdout):
        caps.append((m.group(1), int(m.group(2)) + 1, int(m.group(3)),
                     int(m.group(4)) + 1, int(m.group(5)), m.group(6)))
    return caps


def locate(snippet, occ):
    pre = "(?<![A-Za-z0-9_])" if re.match(r"\w", snippet) else ""
    post = "(?![A-Za-z0-9_])" if re.search(r"\w$", snippet) else ""
    pat = re.compile(pre + re.escape(snippet) + post)
    hits = [i + 1 for i, ln in enumerate(SRC.splitlines()) if pat.search(ln)]
    if len(hits) <= occ:
        raise SystemExit(f"snippet {snippet!r} (occ {occ}) not in source: hits={hits}")
    return hits[occ]


def main():
    with tempfile.NamedTemporaryFile("w", suffix=".cj", delete=False,
                                     dir="/tmp/opencode") as f:
        f.write(SRC)
        path = f.name
    caps = run_query(path)
    passed = failed = 0
    for exp in EXPECT:
        cap, snippet = exp[0], exp[1]
        occ = exp[2] if len(exp) > 2 else 0
        line = locate(snippet, occ)
        got = [(c[0], c[5]) for c in caps if c[1] <= line <= c[3]]
        if cap is None:
            bad = [g for g in got if g[1] == snippet]
            if bad:
                print(f"FAIL: `{snippet}` (line {line}) captured as {bad[0][0]}, expected bare")
                failed += 1
            else:
                passed += 1
            continue
        text = exp[3] if len(exp) > 3 else snippet
        if any(g[0] == cap and g[1] == text for g in got):
            passed += 1
        else:
            print(f"FAIL: expected `{snippet}` (line {line}) as @{cap}; got {got}")
            failed += 1
    print(f"\n{passed} passed, {failed} failed")
    os.unlink(path)
    return 1 if failed else 0


if __name__ == "__main__":
    sys.exit(main())
