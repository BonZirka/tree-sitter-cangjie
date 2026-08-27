// EXEC:%frontendCompiler %typecheck %cmp_opt %f 2>&1 | compare %f

class A{
    A(let _:Int64){}
}
struct B{
    B(let _:Int64){}
}
class C{
    C(var _:Int64){}
}
struct D{
    D(var _:Int64){}
}

main():Unit{
    let a = A(1)
    let b = B(1)
    var c = C(1)
    var d = D(1)
}

/* SCAN
error: wildcard cannot be used as member name
 ==> wildcard_in_primary_constructor.cj:4:11:
  | 
4 |     A(let _:Int64){}
  |           ^ 
  | 

error: wildcard cannot be used as member name
 ==> wildcard_in_primary_constructor.cj:7:11:
  | 
7 |     B(let _:Int64){}
  |           ^ 
  | 

error: wildcard cannot be used as member name
  ==> wildcard_in_primary_constructor.cj:10:11:
   | 
10 |     C(var _:Int64){}
   |           ^ 
   | 

error: wildcard cannot be used as member name
  ==> wildcard_in_primary_constructor.cj:13:11:
   | 
13 |     D(var _:Int64){}
   |           ^ 
   | 

4 errors generated, 4 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
