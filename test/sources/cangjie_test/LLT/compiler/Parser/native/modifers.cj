// (DEBUG_OPTION)EXEC:%frontendCompiler %typecheck %cmp_opt %f 2>&1 | compare %f

foreign class A{
    public static func foo():Unit
}

foreign interface IA{ 
    func a():Unit
    func b():Unit
    static func c():Unit
}

main():Unit{

}

/* SCAN
error: unexpected class declaration
 ==> modifers.cj:3:1:
  | 
3 | foreign class A{
  | ^ 
  | 

error: unexpected interface declaration
 ==> modifers.cj:7:1:
  | 
7 | foreign interface IA{ 
  | ^ 
  | 

2 errors generated, 2 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
