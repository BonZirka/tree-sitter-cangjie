// EXEC-PIPE-1: %compiler %cmp_opt %n.cj -o %n.%suffix 2>&1 | compare %f

abstract class C1 {
    public mut prop a: Int64
}
class A <: C1 {
}

main() {
    return 0
}

/* SCAN
error: class 'A' missing abstract modifier, otherwise abstract function or property should be implemented
 ==> prop.cj:6:1:
  | 
6 |   class A <: C1 {
  |  _^
7 | | }
  | |_^
  | 
note: unimplemented abstract property 'a'
 ==> prop.cj:4:5:
  | 
4 |     public mut prop a: Int64
  |     ^^^^^^^^^^^^^^^^^^^^^^^^ 
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
