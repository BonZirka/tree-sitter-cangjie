// EXEC: %compiler %noColor %n.cj 2>&1 | compare %f

class A {}

extend A {
    public func f() {}
}
extend `A` {
    public func f() {}
}
main() {
    0
}

/* SCAN
error: extend member 'f' is not allowed to shadow members of 'extend A'
 ==> extend_decl.cj:6:17:
  | 
6 |     public func f() {}
  |                 ^ 
  | 

error: extend member 'f' is not allowed to shadow members of 'extend A'
 ==> extend_decl.cj:9:17:
  | 
9 |     public func f() {}
  |                 ^ 
  | 

2 errors generated, 2 errors printed.
*/
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
