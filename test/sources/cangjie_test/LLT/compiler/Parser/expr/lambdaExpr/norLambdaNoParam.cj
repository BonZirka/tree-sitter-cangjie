// EXEC-1: %compiler %cmp_opt %n.cj -o %output 

let f1: (Int64, Int64)->Int64 = {a: Int64, b: Int64 => a + b}
var f2: () -> Int32 = { => 123 }


main() {
    f2 = { 123 }
}


/* SCAN
error: expected '=>' in lambda expression, found literal '123'
 ==> norLambda.cj:8:12:
  | 
8 |     f2 = { 123 }
  |            ^^^ expected '=>' here
  | 

1 error generated, 1 error printed.
*/
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
