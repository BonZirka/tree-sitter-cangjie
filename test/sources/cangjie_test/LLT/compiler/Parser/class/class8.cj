// EXEC: %compiler %cmp_opt %n.cj -o %n.%suffix 2>&1 | compare %f



 open class Base {
    public var c: Int64 = 1
     public mut prop a: Int64  {
         get(){
            return 0

        }
        set(v){
            return ()
        }
    }

}

open class A <: Base {
    public mut prop a: Int64 { 
        get() {
            return 0
        }
         set(v){}
    }
        public func f() {
            return 0
        }

}

abstract class C1{
     public prop a: Int64
}
class C2 <: C1 {
     private var x :Int64 = 0
     public mut prop a: Int64 {  
        get() {
            return x
        }
     }
}

main():Unit{
    
}

/* SCAN
error: property must have accessors
  ==> class8.cj:37:6:
   | 
37 |        public mut prop a: Int64 {  
   |  ______^
38 | |         get() {
   | | ...
41 | |      }
   | |______^
   | 

error: cannot override property 'a'
  ==> class8.cj:20:21:
   | 
20 |     public mut prop a: Int64 { 
   |                     ^ 
   | 
note: the parent property is not modified by 'open'
 ==> class8.cj:7:22:
  | 
7 |      public mut prop a: Int64  {
  |                      ^ 
  | 

2 errors generated, 2 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

