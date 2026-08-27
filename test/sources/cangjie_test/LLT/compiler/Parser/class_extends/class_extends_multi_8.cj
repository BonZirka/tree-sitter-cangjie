// EXEC: %compiler %cmp_opt %f -o %n.%suffix 2>&1 | compare %f



open class A{
     public var a:Int64 = 1
}
class B <:  &{}

/* SCAN
error: expected type name after '<:', found '&'
 ==> class_extends_multi_8.cj:8:13:
  | 
8 | class B <:  &{}
  |         ~~  ^ expected type name here
  |         |
  |         after '<:'
  | 

error: expected type name after '&', found '{'
 ==> class_extends_multi_8.cj:8:14:
  | 
8 | class B <:  &{}
  |             ~^ expected type name here
  |             |
  |             after '&'
  | 

2 errors generated, 2 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
