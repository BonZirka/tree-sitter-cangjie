# tree-sitter-cangjie agent rules

## Build / generate

- MUST run grammar regeneration via `python3 scripts/tsbuild.py` (runs `tree-sitter generate`, compiles the Neovim parser `.so` to `~/.local/share/nvim/site/parser/cangjie.so`, and copies `queries/` to the Neovim query directory). Never call `tree-sitter generate` directly.

## Environment

- CLI runs use `XDG_CACHE_HOME=/tmp/opencode/ts-cache XDG_CONFIG_HOME=/tmp/opencode/ts-config`.
- Corpus harness: `python3 scripts/golden.py --ci --jobs 8` (timeout 900 s); rebase with `--update-all`.

## Memory discipline (CRITICAL)

- Accidental OOM kills the session. Containment strategy (user-mandated):
  - Every `tree-sitter` run gets a short timeout (~3 s; typical parse <150 ms). `scripts/golden.py` enforces this per subprocess (`PARSE_TIMEOUT`); standalone runs use `timeout 3 tree-sitter ...`.
  - `python3 scripts/tsbuild.py` at most one at a time (compiling `src/parser.c` is the single heaviest operation).
  - `cjc` — sequentially, one file at a time, each under `timeout 120`.
  - Batch scripts: worker pools ≤ 8, skip files > 100 KB unless needed.
  - Do NOT use `ulimit -v` — it makes cc segfault (fake crashers).
