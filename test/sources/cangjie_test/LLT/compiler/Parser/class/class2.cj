// EXEC: %compiler %cmp_opt %n.cj -o %n.%suffix 2>&1 | compare %f



 class Base2 {
    public  mut  prop d:Int64 { 
  }
 }

 class Base2 {
    public  prop  d:Int64 { 
  }
 }

 class Base3 {
    public  prop  d:Int64 {
        set(v) {}
  }
 }

  class Base4 {
    public  prop  d:Int64 { 
        set(v) {}
  }
 }


 class Base5 {
    public  mut  prop d:Int64 {
        get()x{ 

             return 123
        }
        set(v) {
            return ()
        }
  }

 }

  class Base6 {
     public  mut  prop d:Int64 {
         get(): Int64{ 

              return 123
         }
         set(v) {
             return ()
         }
   }

  }

 class Base7 {
    public mut prop du{ 
        get(){
           2
        }
        set(v) {

        }
    }
 }

 class Base12 {
     public mut prop du:Int64{
         get(){
            2
         }
        set(v) {
            return 123  
        }
     }
 }


class Base13 {
    public var c: Int64 = 1
    public func f() {
        return 0
    }
    public static mut prop a: Int64 {
         get(){
                c 
                f() 
            return 2
        }
        set(v){
        }
    }
 }

/* SCAN
error: expected '{', found 'x'
  ==> class2.cj:30:14:
   | 
30 |         get()x{ 
   |              ^ expected '{' here
   | 

error: expected '{', found ':'
  ==> class2.cj:43:15:
   | 
43 |          get(): Int64{ 
   |               ^ expected '{' here
   | 

error: expected ':', found '{'
  ==> class2.cj:55:23:
   | 
55 |     public mut prop du{ 
   |                       ^ expected ':' here
   | 
   # note: property declaration must declare type explicitly

3 errors generated, 3 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
