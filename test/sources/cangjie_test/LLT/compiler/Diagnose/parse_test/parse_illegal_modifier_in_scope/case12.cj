// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

interface foo {
    open func foo(b!: Int64 = 2) {}
}

main() {
    return 0
}

/* SCAN
warning: redundant modifier: 'open'
  ==> case12.cj:11:5:
   | 
10 | interface foo {
   | ~~~~~~~~~ 
11 |     open func foo(b!: Int64 = 2) {}
   |     ^^^^ interface member implies 'open'
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff parser`

error: optional parameter cannot be used in 'open' function
  ==> case12.cj:11:19:
   | 
11 |     open func foo(b!: Int64 = 2) {}
   |                   ^^^^^^^^^^^^^ 
   | 

1 error generated, 1 error printed.
1 warning generated, 1 warning printed.
*/
