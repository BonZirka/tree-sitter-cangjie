# GOLDEN harness sources

The `.cj` files the GOLDEN harness (`scripts/golden.py`, run via
`make golden` / `make golden-ci`) parses come from the upstream
repositories, as git submodules pinned to one commit each:

| Path                        | Upstream                                        | Pinned commit | Used                          |
|-----------------------------|-------------------------------------------------|---------------|-------------------------------|
| `cangjie_runtime/`          | https://gitcode.com/Cangjie/cangjie_runtime | `6761305f`    | every `.cj` under `stdlib/`   |
| `cangjie_stdx/`             | https://gitcode.com/Cangjie/cangjie_stdx    | `9581a10b`    | every `.cj`                   |
| `cangjie_test/`             | https://gitcode.com/Cangjie/cangjie_test    | `54f95852`    | the files `cangjie_test.manifest` lists, under `testsuites/` |

Fetch them once after cloning:

```sh
make sources           # scripts/fetch_sources.sh
make golden-ci         # verify: exits non-zero on any regression
make golden            # record new / rebase changed sources
```

A golden records the sha256 of its source, so a moved pin re-records the
goldens of whichever files changed (REBASED) and leaves the rest alone. To
move one:

```sh
git -C test/sources/cangjie_stdx fetch --depth 1 origin <commit>
git -C test/sources/cangjie_stdx checkout <commit>
make golden && git add test/sources/cangjie_stdx test/golden
```

To run against a local (non-submodule) checkout instead:

```sh
make golden-ci GOLDEN_ROOTS=~/projects/cangjie-repos/cangjie_stdx
```

Keys assigned to each file are relative to this directory (or to
`~/projects/cangjie-repos` for legacy checkouts), which keeps existing
golden snapshots stable across both layouts. A `cangjie_test` file's key
leaves out `testsuites/` (`cangjie_test/HLT/...`).

`make sources` fetches only the pinned commits (the submodules are
shallow), and of `cangjie_test` only the sampled files: it fetches the
commit without its blobs, and a sparse checkout of the manifest's paths
downloads just those. A plain `git submodule update --init` works too, but
takes all of `cangjie_test` (~175k files, ~250 MB).

## The `cangjie_test` sample

`cangjie_test` has ~97k `.cj` files, so the harness parses a sample of it:
`cangjie_test.manifest`, one path per line, relative to `testsuites/`. The
manifest is the source of truth — the pinned commit is the one every file
it lists matches. It was made by `scripts/sample_cangjie_test.py` (seed 42,
5% per stratum capped at 300; full syntax-focused dirs), which draws from
whatever tree it is given, so running it again gives a different sample.
To take a new one:

```sh
python3 scripts/sample_cangjie_test.py --output test/sources/cangjie_test.manifest
make golden && python3 scripts/golden.py --prune
```

`cangjie_test.classification.txt` lists the sampled files with ERROR nodes
at the time they were vendored; `scripts/count_negatives.sh` counts them.

Some upstream files have CRLF line endings. The submodules keep them as the
upstream has them, so their goldens hash the CRLF bytes.

The Cangjie sources are Apache-2.0 with Runtime Library Exception
(see https://cangjie-lang.cn/pages/LICENSE).
