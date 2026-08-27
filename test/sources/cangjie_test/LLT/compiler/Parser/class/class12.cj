// EXEC: %compiler %cmp_opt %n.cj -o %n.%suffix
// EXEC: %run %run_opt %n.%suffix

abstract class C1{
     public mut prop a: Int64
}
class A <: C1 {
     private var x :Int64 = 0
     public mut prop a: Int64 {
        get() {
            return x
        }
        set(v) {
          x = v
        }
     }
}

interface I1{
         mut prop a: Int64
}
class B <: I1 {
     private var x :Int64 = 0
     public mut prop a: Int64 {
        get() {
            return x
        }
        set(v) {
          x = v
        }
     }

}

main() {
    var test  =  A()
    var test1  =  B()
    test.a = 2
    test1.a = 3
    if(test.a == 2 && test1.a == 3) {
        print("${test.a}")
      return 0
    }
    return 1
}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
