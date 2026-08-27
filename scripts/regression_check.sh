#!/usr/bin/env bash
# Regression check: ensure no file in the baseline acquires an (ERROR) node.
# Parses each file in ISOLATION (one tree-sitter process per file) so external-
# scanner state cannot leak. Exits 0 (clean) or 1 (regression).
#
# Usage:
#   scripts/regression_check.sh                       # full baseline (~25s)
#   scripts/regression_check.sh test/regression/baseline_noerror.txt   # explicit
#   scripts/regression_check.sh "" 3000               # 3000-file random sample (~5s)
set -uo pipefail
cd "$(dirname "$0")/.."

BASELINE="${1:-test/regression/baseline_noerror.txt}"
SAMPLE="${2:-}"
JOBS="${JOBS:-16}"

command -v tree-sitter >/dev/null || { echo "tree-sitter not on PATH" >&2; exit 2; }

[ -f "$BASELINE" ] || { echo "Baseline not found: $BASELINE (run scripts/build_baseline.sh)" >&2; exit 2; }

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

if [ -n "$SAMPLE" ]; then
  shuf -n "$SAMPLE" --random-source=/dev/urandom "$BASELINE" > "$TMP/scan.txt"
else
  cp "$BASELINE" "$TMP/scan.txt"
fi
TOTAL=$(wc -l < "$TMP/scan.txt")

# Per-file isolated parse; record files with an (ERROR node.
cat "$TMP/scan.txt" | xargs -P "$JOBS" -I {} sh -c \
  'tree-sitter parse "{}" 2>/dev/null | grep -q "(ERROR" && echo "{}"' \
  > "$TMP/error_files.txt" 2>/dev/null || true
sort -u "$TMP/error_files.txt" -o "$TMP/error_files.txt"
ERRORS=$(wc -l < "$TMP/error_files.txt")

echo "Scanned            : $TOTAL files"
echo "Files with (ERROR) : $ERRORS"

if [ "$ERRORS" -gt 0 ]; then
  echo "=== REGRESSION: baseline files with (ERROR) ==="
  cat "$TMP/error_files.txt"
  exit 1
fi
echo "OK: no (ERROR) nodes in any scanned baseline file."
