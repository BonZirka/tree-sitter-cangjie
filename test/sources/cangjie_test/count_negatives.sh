#!/bin/bash
neg=$(grep -c '^ERRORS' test/sources/cangjie_test/CLASSIFICATION.txt)
tot=$(find test/sources/cangjie_test -name '*.cj' | wc -l)
echo "negatives: $neg / total: $tot"

