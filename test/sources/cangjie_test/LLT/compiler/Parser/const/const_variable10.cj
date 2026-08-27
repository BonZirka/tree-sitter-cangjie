// ERRCHECK: %compiler %noColor %f -o %output

class A{
    // const A = 1
    const AAA(a, b) = (1, 2)
    // var B(a, b) = (1, 2)
    A(a:Int64, b:Int64){}
}

class B{
    const B
    const B(_, b) = (1, 2)
    const B(_:Int64, b:Int64){}
}

class C{
    const C(a) = (1)
    const C(a!:Int64){}
}

class D{
    const D(){}
}

main() {}

/* SCAN
error: enum patterns cannot be used in class or struct body
 ==> const_variable10.cj:5:11:
  | 
3 | class A{
  | ~~~~~ in class body
4 |     // const A = 1
5 |     const AAA(a, b) = (1, 2)
  |           ^^^^^^^^^ 
  | 

error: expected static before const member variable
  ==> const_variable10.cj:11:5:
   | 
11 |     const B
   |     ^^^^^ const member variable must be modified by static
   | 

error: expected ':', found ','
  ==> const_variable10.cj:12:14:
   | 
12 |     const B(_, b) = (1, 2)
   |              ^ expected ':' here
   | 

error: expected ':', found ')'
  ==> const_variable10.cj:12:17:
   | 
12 |     const B(_, b) = (1, 2)
   |                 ^ expected ':' here
   | 

error: body of main constructor 'B' is missing
  ==> const_variable10.cj:12:18:
   | 
12 |     const B(_, b) = (1, 2)
   |                  ^ missing main constructor body here
   | 

error: expected ';' or '<NL>', found '='
  ==> const_variable10.cj:12:19:
   | 
12 |     const B(_, b) = (1, 2)
   |                   ^ expected ';' or '<NL>' here
   | 

error: expected ':', found ')'
  ==> const_variable10.cj:17:14:
   | 
17 |     const C(a) = (1)
   |              ^ expected ':' here
   | 

error: body of main constructor 'C' is missing
  ==> const_variable10.cj:17:15:
   | 
17 |     const C(a) = (1)
   |               ^ missing main constructor body here
   | 

9 errors generated, 8 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
