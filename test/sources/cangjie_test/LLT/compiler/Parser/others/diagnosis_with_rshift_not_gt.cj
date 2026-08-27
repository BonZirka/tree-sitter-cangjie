// EXEC: %compiler %cmp_opt %f -o %output 2>&1 | compare %f

main() {
    var public = 1
    var open = 1
    var a = [1 << 
    public, open 
    >> 
    -(-1)]
    return a[0] + a[1] - 2
}

/* SCAN
warning: possibly confusing line terminator
 ==> diagnosis_with_rshift_not_gt.cj:7:18:
  | 
7 |       public, open 
  |               ~    ^ 
  |  _____________|
8 | |     >> 
  | |_____~ possibly confusing line terminator between 'open' and '>>'
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff parser`

1 warning generated, 1 warning printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
