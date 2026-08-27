// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

func foo(a!: Int64, b!: Int64, c!: Int64) {}

main() {
    let arg = 1
    foo(arg, a: arg, b: arg)
}

/* SCAN
error: missing argument prefix 'c:' for named parameter
  ==> OnlyOneNotMatchDisorder.cj:14:9:
   | 
14 |     foo(arg, a: arg, b: arg)
   |         ^^^ 
   | 

1 error generated, 1 error printed.
*/
