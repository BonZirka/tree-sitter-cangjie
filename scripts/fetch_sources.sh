#!/bin/sh
# Fetches the GOLDEN corpus (test/sources/README.md): the runtime and stdx
# submodules shallow, and of cangjie_test (~175k files) only the ones its
# manifest lists — a blobless fetch of the pinned commit, sparse-checked-out
# before anything is downloaded. Safe to run again.
set -eu
cd "$(dirname "$0")/.."

git submodule update --init --depth 1 test/sources/cangjie_runtime test/sources/cangjie_stdx

dir=test/sources/cangjie_test
sha=$(git rev-parse "HEAD:$dir")
git submodule init "$dir"
if [ ! -e "$dir/.git" ]; then
    git init -q "$dir"
    git -C "$dir" remote add origin "$(git config "submodule.$dir.url")"
fi
git -C "$dir" fetch -q --depth 1 --filter=blob:none origin "$sha"
# Manifest paths are literal, sparse-checkout's are gitignore patterns.
sed -e 's/[][*?!\\]/\\&/g' -e 's|^|/testsuites/|' test/sources/cangjie_test.manifest |
    git -C "$dir" sparse-checkout set --no-cone --stdin
git -C "$dir" checkout -q --detach "$sha"
git submodule absorbgitdirs "$dir"
git submodule status
