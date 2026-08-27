// EXEC: %compiler %cmp_opt %n.cj -o %n.%suffix 2>&1 | compare %f



class A {
       public var x :Int64 = 0
      private mut prop a: Int64 {
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
    test.a = 4 
    return 1
}

/* SCAN
error: can not access field 'a'
  ==> class13.cj:18:5:
   | 
18 |     test.a = 4 
   |     ^ 
   | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
