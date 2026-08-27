// EXEC-PIPE-1: %compiler %cmp_opt %f -o %output 2>&1 |compare %f

@C
struct A {
}

class B {
  public var a : A = A()
  public static var b : A = A()
}

struct C {
  public var b : A = A()
  public static var c : A = A()
}

class D<T> {}
func m() {
    var a : D<A>
    var d : (A, A)
}

enum E {
   e(A)
}

/* SCAN
error: member func 'e' of enum 'E' mustn't has struct with @C
  ==> test.cj:24:4:
   | 
24 |    e(A)
   |    ^ 
   | 

error: tuple member mustn't be struct with @C
  ==> test.cj:20:14:
   | 
20 |     var d : (A, A)
   |              ^ 
   | 

error: 'main' is missing
 ==> test.cj:1:1:
  | 
1 | // EXEC-PIPE-1: %compiler %cmp_opt %f -o %output 2>&1 |compare %f
  | ^ 
  | 

3 errors generated, 3 errors printed.
*/
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
