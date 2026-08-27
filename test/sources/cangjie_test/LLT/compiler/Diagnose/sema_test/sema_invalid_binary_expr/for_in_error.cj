// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC:%frontendCompiler %typecheck %cmp_opt %f 2>&1 | compare %f


var TEST = "test"

interface Runnable {
    func run(): Unit
}

open class Thread <: Runnable {
    var name: String
    var m: Runnable
    open func start() {
        return spawn {m.run()}
    }
    func run() {
        m.run()
    }
    init(target: Runnable, n: String) {
        m = target
        name = n
    }
}

class Gc_TestCase_1 <: Runnable {
    func run() {}
}

main() {
    for (i in 0..1) {
        var b: Thread = Thread(Gc_TestCase_1(), TEST + i)
    }
    return 0
}

/* SCAN
error: the visibility of an 'open' function must be 'public' or 'protected'
  ==> for_in_error.cj:20:15:
   | 
20 |     open func start() {
   |               ^^^^^ 
   | 

error: invalid binary operator '+' on type 'Struct-String' and 'Int64'
  ==> for_in_error.cj:38:54:
   | 
38 |         var b: Thread = Thread(Gc_TestCase_1(), TEST + i)
   |                                                      ^ 
   | 
   # note: you may want to implement 'operator func +(right: Int64)' for type 'Struct-String'

error: a deriving member must be at least as visible as its base member
  ==> for_in_error.cj:23:10:
   | 
23 |     func run() {
   |          ^^^ the visibility of the deriving 'run' is 'internal'
   | 
note: the visibility of the base 'run' is 'public'
  ==> for_in_error.cj:14:10:
   | 
14 |     func run(): Unit
   |          ^^^ the base 'run' is in 'interface'
   | 

error: a deriving member must be at least as visible as its base member
  ==> for_in_error.cj:33:10:
   | 
33 |     func run() {}
   |          ^^^ the visibility of the deriving 'run' is 'internal'
   | 
note: the visibility of the base 'run' is 'public'
  ==> for_in_error.cj:14:10:
   | 
14 |     func run(): Unit
   |          ^^^ the base 'run' is in 'interface'
   | 

4 errors generated, 4 errors printed.
*/
