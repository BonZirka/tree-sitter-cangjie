// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

open class A {}

open class B <: A {}

open class C <: B {}

open class D {}

open class E <: D {}

open class F <: E {}

open class G {}

open class H <: G {}

open class I <: H {}

func f<X, Y, Z>(a: (X, Y, Z)) where X <: A, Y <: D, Z <: G {
    1
} //F1

func f<X, Y, Z>(a: (X, Y, Z)) where X <: A, Y <: D, Z <: H {
    0
} //F2

main() {
    f((C(), F(), I()))
}

/* SCAN
error: function 'f' has overload conflicts
  ==> case1.cj:32:6:
   | 
32 | func f<X, Y, Z>(a: (X, Y, Z)) where X <: A, Y <: D, Z <: H {
   |      ^ 
   | 
   # note: generic constraints are not involved in the overloading
note: conflict with the declaration
  ==> case1.cj:28:6:
   | 
28 | func f<X, Y, Z>(a: (X, Y, Z)) where X <: A, Y <: D, Z <: G {
   |      ^ 
   | 

1 error generated, 1 error printed.
*/
