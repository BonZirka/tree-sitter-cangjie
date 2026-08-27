// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %n.cj -o %output


main() {
    var i : Int64 = 1
    var x : Int64 = 2
    var flag : Bool = true
    var a : Int64 = match (i) {
        case _ where (+x) => i
    }
    return (a-1)
}


/* SCAN
error: expected expression after '(', found '+'
  ==> match_where.cj:10:23:
   | 
10 |         case _ where (+x) => i
   |                       ^ expected expression here
   | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
