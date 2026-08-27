// ERRCHECK: %compiler %cmp_opt %n.cj -o %output

main() {
    var x : Int32 = 0
    var i : Int64 = 0
    while (i < Math.min(Math.min(a.size, b.size), c.size)) {
        x += a[i] + b[+= a[i] + b[+= a[i] + b[i] + c[i]]
        i++
    }
    return x
}

/* SCAN
error: expected expression after [, found +=
 ==> illegal_index_access.cj:7:23:
  | 
7 |         x += a[i] + b[+= a[i] + b[+= a[i] + b[i] + c[i]]
  |                       ^ expected expression here
  | 

error: unclosed delimiter: '['
 ==> illegal_index_access.cj:7:58:
  | 
7 |         x += a[i] + b[+= a[i] + b[+= a[i] + b[i] + c[i]]
  |                      ~                                   ^ expected ']' here
  |                      |
  |                      to match this opening '['
  | 

2 errors generated, 2 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
