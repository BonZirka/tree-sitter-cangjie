// ERRCHECK: %compiler %cmp_opt %n.cj -o %output

main(): Int64 {
    var a:Int8 = 7
    var b:Int8 = 2
    var c:Int8 = 0
    var d:Int8 = 0
    var e:Int8 = 10
    c = a^e&b
    d = a^(e&b)
    ?f (c != d) {
        return 1
    }
    return 0 
}

/* SCAN
error: expected expression or declaration, found '?'
  ==> illegal_ifexpr.cj:11:5:
   | 
11 |     ?f (c != d) {
   |     ^ expected expression or declaration here
   | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
