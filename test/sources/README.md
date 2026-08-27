# Vendored GOLDEN harness sources

The `.cj` files under this directory are the reference corpus used by
`scripts/golden.py` (run via `make golden` / `make golden-ci`). They are
vendored so a fresh clone can verify and rebase the golden baselines
without checking out the upstream repositories.

| Path                        | Upstream                                        | Pinned commit |
|-----------------------------|-------------------------------------------------|---------------|
| `cangjie_runtime/stdlib/`   | https://gitcode.com/Cangjie/cangjie_runtime | `6761305f`    |
| `cangjie_stdx/`             | https://gitcode.com/Cangjie/cangjie_stdx    | `9581a10`     |

Only `*.cj` sources are vendored (767 files). To refresh, copy the same
relative paths from an updated checkout and re-run:

```sh
make golden            # record new / rebase changed sources
make golden-ci         # verify: exits non-zero on any regression
```

To run against a local (non-vendored) checkout instead:

```sh
make golden-ci GOLDEN_ROOTS=~/projects/cangjie-repos/cangjie_stdx
```

Keys assigned to each file are relative to this directory (or to
`~/projects/cangjie-repos` for legacy checkouts), which keeps existing
golden snapshots stable across both layouts.

These sources are distributed under their own license (MulanPSL-2.0,
see the upstream repositories).
