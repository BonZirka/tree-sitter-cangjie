// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

main() {
    let arr = [1, 2, 3, 4, 5]

    arr[..3 : 1] = 1
    return 0
}

/* SCAN
error: unexpected ':' in index access
  ==> case1.cj:13:13:
   | 
13 |     arr[..3 : 1] = 1
   |         ~~~ ^ unexpected ':' here
   | 
   # note: range expression in index access cannot have step if it is without start or end

1 error generated, 1 error printed.
*/
