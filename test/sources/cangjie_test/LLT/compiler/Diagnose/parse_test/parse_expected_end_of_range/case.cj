// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output

main() {
    let arr = [1, 2, 3, 4, 5]

    arr[.. : 1] = 1
    arr[1.. : 1] = 1
    return 0
}

/* SCAN
error: unexpected ':' in index access
  ==> case.cj:13:12:
   | 
13 |     arr[.. : 1] = 1
   |         ~~ ^ unexpected ':' here
   | 
   # note: range expression in index access cannot have step if it is without start or end

error: unexpected ':' in index access
  ==> case.cj:14:13:
   | 
14 |     arr[1.. : 1] = 1
   |         ~~~ ^ unexpected ':' here
   | 
   # note: range expression in index access cannot have step if it is without start or end

2 errors generated, 2 errors printed.
*/
