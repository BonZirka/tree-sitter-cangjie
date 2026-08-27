// EXEC: %compiler %cmp_opt %n.cj -o %n.%suffix 2>&1 | compare %f



class Base12  {
    public var du: Int64 = 1
     public prop a: Int64  { 

    }
    public func f():Int64 {
        a = 2 
        return 0
    }
 }
main() {
    var x  = Base12()
        x.a = 4 
        if(x.a == 4) {
            print("${x.a}")
            return 0
        }
    return 1
}

/* SCAN
error: property must have accessors
 ==> class7.cj:7:6:
  | 
7 |        public prop a: Int64  { 
  |  ______^
8 | | 
9 | |     }
  | |_____^
  | 

error: 'a' is not a member of class 'Base12'
  ==> class7.cj:18:14:
   | 
18 |         if(x.a == 4) {
   |              ^ 
   | 

error: 'a' is not a member of class 'Base12'
  ==> class7.cj:19:24:
   | 
19 |             print("${x.a}")
   |                        ^ 
   | 

error: cannot assign to immutable value
  ==> class7.cj:11:9:
   | 
11 |         a = 2 
   |         ^^^^^ 
   | 
note: property 'a' is immutable
 ==> class7.cj:7:18:
  | 
7 |      public prop a: Int64  { 
  |                  ^ 
  | 

error: cannot assign to immutable value
  ==> class7.cj:17:9:
   | 
17 |         x.a = 4 
   |         ^^^^^^^ 
   | 
note: property 'a' is immutable
 ==> class7.cj:7:18:
  | 
7 |      public prop a: Int64  { 
  |                  ^ 
  | 

5 errors generated, 5 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
