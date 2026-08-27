// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %n.cj -o %output


main() : Int64 {
    var a:?Int64 = Some(1)
    return 0
}

class A<T>{}
type C = ?A<O


/* SCAN
error: unclosed delimiter: '<'
  ==> typealias_fuzz.cj:11:13:
   | 
11 | type C = ?A<O
   |            ~^ expected '>' here
   |            |
   |            to match this opening '<'
   | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
