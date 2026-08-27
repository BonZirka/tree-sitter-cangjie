// EXEC: %compiler %cmp_opt %n.cj -o %n.%suffix 2>&1 | compare %f



class Base12  {
    public var du: Int64 = 1
     public prop a: Int64  {
         get(){
            return du

        }
    }
    public func f():Int64 {
        a = 2  
        return 0
    }
 }
main() {
    var x  = Base12()
        x.a = 4 
    return 0
}

/* SCAN
error: cannot assign to immutable value
  ==> class6.cj:14:9:
   | 
14 |         a = 2  
   |         ^^^^^ 
   | 
note: property 'a' is immutable
 ==> class6.cj:7:18:
  | 
7 |      public prop a: Int64  {
  |                  ^ 
  | 

error: cannot assign to immutable value
  ==> class6.cj:20:9:
   | 
20 |         x.a = 4 
   |         ^^^^^^^ 
   | 
note: property 'a' is immutable
 ==> class6.cj:7:18:
  | 
7 |      public prop a: Int64  {
  |                  ^ 
  | 

2 errors generated, 2 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
