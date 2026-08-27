// EXEC: %compiler %cmp_opt %f -o %n.%suffix 2>&1 | compare %f



open class A{
     public var a:Int64 = 1
}
class B <: A & A.C{} 

main():Unit{
  
}

/* SCAN
error: undeclared type name 'C'
 ==> class_extends_multi_10.cj:8:18:
  | 
8 | class B <: A & A.C{} 
  |                  ^ 
  | 

error: class 'B' can only inherit a class or implement interfaces
 ==> class_extends_multi_10.cj:8:16:
  | 
8 | class B <: A & A.C{} 
  |                ^ 
  | 

2 errors generated, 2 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
