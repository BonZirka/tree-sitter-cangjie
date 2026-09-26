#!/bin/bash
neg=$(grep -c '^ERRORS' test/sources/cangjie_test.classification.txt)
tot=$(grep -c . test/sources/cangjie_test.manifest)
echo "negatives: $neg / total: $tot"
