#!/usr/bin/env bash
# Build the regression baseline: the set of .cj files that parse with NO (ERROR)
# node under the CURRENT grammar, parsed in ISOLATION (one tree-sitter process
# per file) so external-scanner state cannot leak between files.
#
# Output: test/regression/baseline_noerror.txt  (files with no ERROR)
#         test/regression/error_files.txt      (files with ERROR — backlog)
set -euo pipefail
cd "$(dirname "$0")/.."

CANGJIE_ROOT="${CANGJIE_ROOT:-/home/huawei/newrepos/main}"
JOBS="${JOBS:-16}"
OUTDIR=test/regression
mkdir -p "$OUTDIR"

command -v tree-sitter >/dev/null || { echo "tree-sitter not on PATH" >&2; exit 1; }

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

# 1. Collect all .cj sources from cangjie_test + runtime + stdx.
find "$CANGJIE_ROOT/cangjie_test/testsuites" "$CANGJIE_ROOT/cangjie_runtime" \
     "$CANGJIE_ROOT/cangjie_stdx" -name '*.cj' 2>/dev/null \
  | sort -u > "$TMP/all.txt"
TOTAL=$(wc -l < "$TMP/all.txt")
echo "Collecting .cj sources: $TOTAL files"

# 2. Per-file isolated parse; record files that contain an (ERROR node.
#    One tree-sitter process per file => no external-scanner state leakage.
echo "Parsing each file in isolation (-P$JOBS)..."
cat "$TMP/all.txt" | xargs -P "$JOBS" -I {} sh -c \
  'tree-sitter parse "{}" 2>/dev/null | grep -q "(ERROR" && echo "{}"' \
  > "$TMP/error_files.txt" 2>/dev/null || true
sort -u "$TMP/error_files.txt" -o "$TMP/error_files.txt"
ERRORS=$(wc -l < "$TMP/error_files.txt")

# 3. baseline = all - error_files
comm -23 "$TMP/all.txt" "$TMP/error_files.txt" > "$OUTDIR/baseline_noerror.txt"
cp "$TMP/error_files.txt" "$OUTDIR/error_files.txt"

echo
echo "Total .cj sources  : $TOTAL"
echo "Files with (ERROR) : $ERRORS"
echo "Baseline (no-ERROR): $(wc -l < "$OUTDIR/baseline_noerror.txt")"
echo "Saved -> $OUTDIR/baseline_noerror.txt + $OUTDIR/error_files.txt"
