// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

enum foo {
    A | B

    override func foo(b!: Int64 = 2) {}
}

main() {
    return 0
}

/* SCAN
error: 'override' function 'foo' does not have an overridden function in its supertype
  ==> case17.cj:13:5:
   | 
13 |     override func foo(b!: Int64 = 2) {}
   |     ^ 
   | 

1 error generated, 1 error printed.
*/
