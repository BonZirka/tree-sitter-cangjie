// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// EXEC:%frontendCompiler %typecheck %cmp_opt %coverage_opt %f 2>&1 | compare %f

class Test {
    let a: String
    let b: (Int32) -> String

    func foo(x: Int32): String {
        return x.toString()
    }
    func f(x: Int32): String {
        return a
    }
    init() {
        a = "100"
        b = f
    }
    init(x: Int32) {
        this()
        a = this.f(1)
        a = foo(1)
        a = f(1)
        a = this.foo(100)
        b = this.f
        b = f
        b = this.foo
        b = foo
    }
}

func run(): Int64 {
    var test: Test = Test(3)
    var res1: String = test.b(1)
    if (res1 != "1") {
        return 1
    }
    var res2 = test.b
    if (res2(1) != "1") {
        return 1
    }
    var res3 = test.f
    if (res3(2) != "100") {
        return 1
    }

    var res4 = test.f(1)
    if (res4 != "100") {
        return 1
    }
    var res5 = test.foo
    if (res5(3) != "3") {
        return 1
    }
    var res6 = test.foo(1)
    if (res6 != "1") {
        return 1
    }
    return 0
}

main(): Int64 {
    print(run().toString())
    return run()
}

/* SCAN
error: 'f' is not allowed to be accessed before all member variables are initialized
  ==> class_this.cj:21:13:
   | 
21 |         b = f
   |             ^ 
   | 

error: cannot assign to immutable value
  ==> class_this.cj:25:9:
   | 
25 |         a = this.f(1)
   |         ^^^^^^^^^^^^^ 
   | 
note: variable 'a' is immutable
  ==> class_this.cj:10:9:
   | 
10 |     let a: String
   |         ^ 
   | 

error: cannot assign to immutable value
  ==> class_this.cj:26:9:
   | 
26 |         a = foo(1)
   |         ^^^^^^^^^^ 
   | 
note: variable 'a' is immutable
  ==> class_this.cj:10:9:
   | 
10 |     let a: String
   |         ^ 
   | 

error: cannot assign to immutable value
  ==> class_this.cj:27:9:
   | 
27 |         a = f(1)
   |         ^^^^^^^^ 
   | 
note: variable 'a' is immutable
  ==> class_this.cj:10:9:
   | 
10 |     let a: String
   |         ^ 
   | 

error: cannot assign to immutable value
  ==> class_this.cj:28:9:
   | 
28 |         a = this.foo(100)
   |         ^^^^^^^^^^^^^^^^^ 
   | 
note: variable 'a' is immutable
  ==> class_this.cj:10:9:
   | 
10 |     let a: String
   |         ^ 
   | 

error: cannot assign to immutable value
  ==> class_this.cj:29:9:
   | 
29 |         b = this.f
   |         ^^^^^^^^^^ 
   | 
note: variable 'b' is immutable
  ==> class_this.cj:11:9:
   | 
11 |     let b: (Int32) -> String
   |         ^ 
   | 

error: cannot assign to immutable value
  ==> class_this.cj:30:9:
   | 
30 |         b = f
   |         ^^^^^ 
   | 
note: variable 'b' is immutable
  ==> class_this.cj:11:9:
   | 
11 |     let b: (Int32) -> String
   |         ^ 
   | 

error: cannot assign to immutable value
  ==> class_this.cj:31:9:
   | 
31 |         b = this.foo
   |         ^^^^^^^^^^^^ 
   | 
note: variable 'b' is immutable
  ==> class_this.cj:11:9:
   | 
11 |     let b: (Int32) -> String
   |         ^ 
   | 

error: cannot assign to immutable value
  ==> class_this.cj:32:9:
   | 
32 |         b = foo
   |         ^^^^^^^ 
   | 
note: variable 'b' is immutable
  ==> class_this.cj:11:9:
   | 
11 |     let b: (Int32) -> String
   |         ^ 
   | 

9 errors generated, 9 errors printed.
*/
