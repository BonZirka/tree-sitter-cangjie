// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// SEPARATE-FILE: c/c.cj
// EXEC-PIPE-1: %compiler %noColor --experimental c/c.cj --output-type=chir --output-dir ./c --error-count-limit=20 2>&1 | compare %f
package cmp

public common interface I0 {
    abstract prop p1: Unit
    abstract prop p2: Unit { get() { 1 } }
    common abstract prop p3: Unit
    common abstract prop p4: Unit { get() { 1 } }
    abstract static prop p5: Unit
    abstract static prop p6: Unit { get() { 1 } }
    common abstract static prop p7: Unit
    common abstract static prop p8: Unit { get() { 1 } }
}

/* SCAN
error: unexpected modifier 'abstract' on property declaration in interface body
 ==> c/c.cj:5:5:
  | 
4 | public common interface I0 {
  |               ~~~~~~~~~ in interface
5 |     abstract prop p1: Unit
  |     ^^^^^^^^ ~~~~ on property declaration
  |     |
  |     unexpected modifier
  | 

error: only common/specific or Native FFI mirror abstract classes can have explicitly abstract property
 ==> c/c.cj:5:27:
  | 
5 |     abstract prop p1: Unit
  |                           ^ 
  | 

error: unexpected modifier 'abstract' on property declaration in interface body
 ==> c/c.cj:6:5:
  | 
4 | public common interface I0 {
  |               ~~~~~~~~~ in interface
5 |     abstract prop p1: Unit
6 |     abstract prop p2: Unit { get() { 1 } }
  |     ^^^^^^^^ ~~~~ on property declaration
  |     |
  |     unexpected modifier
  | 

error: only common/specific or Native FFI mirror abstract classes can have explicitly abstract property
 ==> c/c.cj:6:43:
  | 
6 |     abstract prop p2: Unit { get() { 1 } }
  |                                           ^ 
  | 

error: unexpected modifier 'abstract' on property declaration in interface body
 ==> c/c.cj:7:12:
  | 
4 | public common interface I0 {
  |               ~~~~~~~~~ in interface
5 |     abstract prop p1: Unit
  | ...
7 |     common abstract prop p3: Unit
  |            ^^^^^^^^ ~~~~ on property declaration
  |            |
  |            unexpected modifier
  | 

error: unexpected modifier 'abstract' on property declaration in interface body
 ==> c/c.cj:8:12:
  | 
4 | public common interface I0 {
  |               ~~~~~~~~~ in interface
5 |     abstract prop p1: Unit
  | ...
8 |     common abstract prop p4: Unit { get() { 1 } }
  |            ^^^^^^^^ ~~~~ on property declaration
  |            |
  |            unexpected modifier
  | 

error: unexpected modifier 'abstract' on property declaration in interface body
 ==> c/c.cj:9:5:
  | 
4 | public common interface I0 {
  |               ~~~~~~~~~ in interface
5 |     abstract prop p1: Unit
  | ...
9 |     abstract static prop p5: Unit
  |     ^^^^^^^^        ~~~~ on property declaration
  |     |
  |     unexpected modifier
  | 

error: only common/specific or Native FFI mirror abstract classes can have explicitly abstract property
 ==> c/c.cj:9:34:
  | 
9 |     abstract static prop p5: Unit
  |                                  ^ 
  | 

error: unexpected modifier 'abstract' on property declaration in interface body
  ==> c/c.cj:10:5:
   | 
4  | public common interface I0 {
   |               ~~~~~~~~~ in interface
5  |     abstract prop p1: Unit
   | ...
10 |     abstract static prop p6: Unit { get() { 1 } }
   |     ^^^^^^^^        ~~~~ on property declaration
   |     |
   |     unexpected modifier
   | 

error: only common/specific or Native FFI mirror abstract classes can have explicitly abstract property
  ==> c/c.cj:10:50:
   | 
10 |     abstract static prop p6: Unit { get() { 1 } }
   |                                                  ^ 
   | 

error: unexpected modifier 'abstract' on property declaration in interface body
  ==> c/c.cj:11:12:
   | 
4  | public common interface I0 {
   |               ~~~~~~~~~ in interface
5  |     abstract prop p1: Unit
   | ...
11 |     common abstract static prop p7: Unit
   |            ^^^^^^^^        ~~~~ on property declaration
   |            |
   |            unexpected modifier
   | 

error: unexpected modifier 'abstract' on property declaration in interface body
  ==> c/c.cj:12:12:
   | 
4  | public common interface I0 {
   |               ~~~~~~~~~ in interface
5  |     abstract prop p1: Unit
   | ...
12 |     common abstract static prop p8: Unit { get() { 1 } }
   |            ^^^^^^^^        ~~~~ on property declaration
   |            |
   |            unexpected modifier
   | 

12 errors generated, 12 errors printed.
*/