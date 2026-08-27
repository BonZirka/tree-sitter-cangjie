// EXEC: %compiler %cmp_opt %f -o %n.%suffix 2>&1 | compare %f



open class A{
     public var a:Int64 = 1
}
class B <: A &

/* SCAN
error: expected type name after '&', found '<EOF>'
 ==> class_extends_multi_4.cj:8:15:
  | 
8 | class B <: A &
  |              ~^ expected type name here
  |              |
  |              after '&'
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
