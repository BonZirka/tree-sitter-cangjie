// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output

@C{}

main() {
    return 0
}

/* SCAN
error: expected declaration, found '{'
  ==> after_build_in.cj:10:3:
   | 
10 | @C{}
   |   ^ expected declaration here
   | 
   # note: only declarations or macro expressions can be used in the top-level

1 error generated, 1 error printed.
*/
