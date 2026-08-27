// EXEC:%frontendCompiler %typecheck %cmp_opt %f 2>&1 | compare %f

foreign class A{
    static func foo():Unit
    var aa:Int64 = 1
    func foo2():Int64
}

main():Int64{
    var a = A()
    a.aa
    a.foo2()
    return 0
}

/* SCAN-IN
error: unexpected class declaration
 ==> call.cj:3:1:
  | 
3 | foreign class A{
  | ^ 
  | 
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
