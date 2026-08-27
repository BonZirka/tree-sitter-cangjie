// ERRCHECK: %compiler %cmp_opt %n.cj -o %output

public interface fatherInterface{
  prop let b: Int64
  prop let b1: Int64 {
    get() {
      b
    }
  }
}

interface MyInterface <: fatherInterface{
  prop let b2: Int64 {
    get() {
      b1
    }
  }
}

extend UInt32 <: MyInterface{
  func foo(){3}
  public prop let b: Int64 {
    get() {
      foo()
    }
  }
}

func macro_expand_test(){
  var u1: MyInterface = UInt32(1)
  var u2: MyInterface = UInt32(1)
  var u3: UInt32 = 1

  if (u1.b1 == 3 && u2.b2 == 3 && u3.b1 == 3 && u3.b2 == 3){
    return 0
  }else{
    return 1
  }
}

/* SCAN
error: expected a property name after keyword 'prop' in property definition, found keyword 'let'
 ==> illegal_prop.cj:4:8:
  | 
4 |   prop let b: Int64
  |   ~~~~ ^^^ expected a property name here
  |   |
  |   after keyword 'prop' in property definition
  | 
help: you could escape keyword as a property name using '`':
  | 
4 |   prop `let` b: Int64
  |        ~~~~~ 
  | 

error: expected a property name after keyword 'prop' in property definition, found keyword 'let'
 ==> illegal_prop.cj:5:8:
  | 
5 |   prop let b1: Int64 {
  |   ~~~~ ^^^ expected a property name here
  |   |
  |   after keyword 'prop' in property definition
  | 
help: you could escape keyword as a property name using '`':
  | 
5 |   prop `let` b1: Int64 {
  |        ~~~~~ 
  | 

error: expected declaration, found '{'
 ==> illegal_prop.cj:5:22:
  | 
5 |   prop let b1: Int64 {
  |                      ^ expected declaration here
  | 

error: expected a property name after keyword 'prop' in property definition, found keyword 'let'
  ==> illegal_prop.cj:13:8:
   | 
13 |   prop let b2: Int64 {
   |   ~~~~ ^^^ expected a property name here
   |   |
   |   after keyword 'prop' in property definition
   | 
help: you could escape keyword as a property name using '`':
   | 
13 |   prop `let` b2: Int64 {
   |        ~~~~~ 
   | 

error: expected declaration, found '{'
  ==> illegal_prop.cj:13:22:
   | 
13 |   prop let b2: Int64 {
   |                      ^ expected declaration here
   | 

error: expected a property name after keyword 'prop' in property definition, found keyword 'let'
  ==> illegal_prop.cj:22:15:
   | 
22 |   public prop let b: Int64 {
   |          ~~~~ ^^^ expected a property name here
   |          |
   |          after keyword 'prop' in property definition
   | 
help: you could escape keyword as a property name using '`':
   | 
22 |   public prop `let` b: Int64 {
   |               ~~~~~ 
   | 

error: expected declaration, found '{'
  ==> illegal_prop.cj:22:28:
   | 
22 |   public prop let b: Int64 {
   |                            ^ expected declaration here
   | 

7 errors generated, 7 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
