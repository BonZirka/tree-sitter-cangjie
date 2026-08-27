// EXEC-PIPE-1: %compiler %cmp_opt %f 2>&1 | compare %f

class Base {
    public   mut  prop d:Int64 
}


class Base2 {
    public   mut  prop d:Int64 , 
}

class Base4 {
    public   mut  prop d:Int64{
        set(){} 
    }
}

class Base5 {
    public   mut  prop d:Int64{ 
        set(v){}
    }
}

class Base6 {
    public   mut  prop d:Int64{
        set( {} 
    }
}

class Base7 {
    public   mut  prop d:Int64{
        set() {} 
        set() {} 
        set() {} 
    }
}

class Base8 {
    public   mut  prop d:Int64{
        set() {}
        set() {} 
    }
}

class Base9 {
    public   mut  prop d:Int64 {
        static set(x){} 
  }
 }

 class Base10 {
    public   mut  prop d:Int64 { 
  }
 }

 class Base11 {
    public   mut  prop d:Int64 { 

        @sset 

  }
 }
 class Base12 {
    public   mut  prop d:Int64 {

        static set(,){} 
  }
 }
 class Base13 {
    public   mut  prop d:Int64 { 
         set(v,){} 
  }
 }

 class Base1 {  
     public   mut  prop d:Int64 {
 } 


/* SCAN
error: expected ';' or '<NL>', found ','
 ==> class1.cj:9:32:
  | 
9 |     public   mut  prop d:Int64 , 
  |                                ^ expected ';' or '<NL>' here
  | 

error: setter must contain 1 parameter
  ==> class1.cj:14:12:
   | 
14 |         set(){} 
   |            ^^ expected 1 parameter inside
   | 

error: unclosed delimiter: '('
  ==> class1.cj:26:13:
   | 
26 |         set( {} 
   |            ~^ expected ')' here
   |            |
   |            to match this opening '('
   | 

error: expected a argument name after '(' in parameter list, found '{'
  ==> class1.cj:26:14:
   | 
26 |         set( {} 
   |            ~ ^ expected a argument name here
   |            |
   |            after '(' in parameter list
   | 

error: setter must contain 1 parameter
  ==> class1.cj:32:12:
   | 
32 |         set() {} 
   |            ^^ expected 1 parameter inside
   | 

error: duplicated 'set' in prop
  ==> class1.cj:33:9:
   | 
31 |     public   mut  prop d:Int64{
   |                   ~~~~ 
32 |         set() {} 
   |         ~~~~~~~~ previous one
33 |         set() {} 
   |         ^^^ duplicated 'set'
   | 

error: setter must contain 1 parameter
  ==> class1.cj:33:12:
   | 
33 |         set() {} 
   |            ^^ expected 1 parameter inside
   | 

error: duplicated 'set' in prop
  ==> class1.cj:34:9:
   | 
31 |     public   mut  prop d:Int64{
   |                   ~~~~ 
32 |         set() {} 
33 |         set() {} 
   |         ~~~~~~~~ previous one
34 |         set() {} 
   |         ^^^ duplicated 'set'
   | 

error: setter must contain 1 parameter
  ==> class1.cj:34:12:
   | 
34 |         set() {} 
   |            ^^ expected 1 parameter inside
   | 

error: setter must contain 1 parameter
  ==> class1.cj:40:12:
   | 
40 |         set() {}
   |            ^^ expected 1 parameter inside
   | 

error: duplicated 'set' in prop
  ==> class1.cj:41:9:
   | 
39 |     public   mut  prop d:Int64{
   |                   ~~~~ 
40 |         set() {}
   |         ~~~~~~~~ previous one
41 |         set() {} 
   |         ^^^ duplicated 'set'
   | 

error: setter must contain 1 parameter
  ==> class1.cj:41:12:
   | 
41 |         set() {} 
   |            ^^ expected 1 parameter inside
   | 

error: expected no modifier before setter function, found 'static'
  ==> class1.cj:47:9:
   | 
47 |         static set(x){} 
   |         ^^^^^^ ~~~ before setter function
   |         |
   |         expected no modifier here
   | 

error: expected 'get' or 'set' in prop body, found '@'
  ==> class1.cj:59:9:
   | 
57 |     public   mut  prop d:Int64 { 
   |                   ~~~~ 
58 | 
59 |         @sset 
   |         ^ expected 'get' or 'set' here
   | 

error: expected no modifier before setter function, found 'static'
  ==> class1.cj:66:9:
   | 
66 |         static set(,){} 
   |         ^^^^^^ ~~~ before setter function
   |         |
   |         expected no modifier here
   | 

error: expected a argument name after '(' in parameter list, found ','
  ==> class1.cj:66:20:
   | 
66 |         static set(,){} 
   |                   ~^ expected a argument name here
   |                   |
   |                   after '(' in parameter list
   | 

error: unclosed delimiter: '{'
  ==> class1.cj:77:3:
   | 
75 |  class Base1 {  
   |              ~ to match this opening '{'
76 |      public   mut  prop d:Int64 {
77 |  } 
   |   ^ expected '}' here
   | 

17 errors generated, 17 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
