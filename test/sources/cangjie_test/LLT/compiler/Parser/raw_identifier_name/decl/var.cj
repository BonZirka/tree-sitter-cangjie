// EXEC: %compiler %noColor %n.cj 2>&1 | compare %f

let x: Int64 = 1
let `x`: Int64 = 1

let y: Float64= 1.2
let `y`: Float64= 1.2

let chr= 'a'
let `chr` = 'a'

var str: String = ""
var `str`: String = ""

let tup: (Int64, Float64) = (3, 3.141592)
let `tup`: (Int64, Float64) = (3, 3.141592)

let ran = 0..10 : 1
let `ran` = 0..10 : 1

class A{}
let cls = A()
let `cls` = A()
main() {
    0
}

/* SCAN
error: redefinition of declaration 'x'
 ==> var.cj:4:6:
  | 
4 | let `x`: Int64 = 1
  |      ^ 
  | 
note: 'x' is previously declared here
 ==> var.cj:3:5:
  | 
3 | let x: Int64 = 1
  |     ^ 
  | 

error: redefinition of declaration 'y'
 ==> var.cj:7:6:
  | 
7 | let `y`: Float64= 1.2
  |      ^ 
  | 
note: 'y' is previously declared here
 ==> var.cj:6:5:
  | 
6 | let y: Float64= 1.2
  |     ^ 
  | 

error: redefinition of declaration 'chr'
  ==> var.cj:10:6:
   | 
10 | let `chr` = 'a'
   |      ^^^ 
   | 
note: 'chr' is previously declared here
 ==> var.cj:9:5:
  | 
9 | let chr= 'a'
  |     ^^^ 
  | 

error: redefinition of declaration 'str'
  ==> var.cj:13:6:
   | 
13 | var `str`: String = ""
   |      ^^^ 
   | 
note: 'str' is previously declared here
  ==> var.cj:12:5:
   | 
12 | var str: String = ""
   |     ^^^ 
   | 

error: redefinition of declaration 'tup'
  ==> var.cj:16:6:
   | 
16 | let `tup`: (Int64, Float64) = (3, 3.141592)
   |      ^^^ 
   | 
note: 'tup' is previously declared here
  ==> var.cj:15:5:
   | 
15 | let tup: (Int64, Float64) = (3, 3.141592)
   |     ^^^ 
   | 

error: redefinition of declaration 'ran'
  ==> var.cj:19:6:
   | 
19 | let `ran` = 0..10 : 1
   |      ^^^ 
   | 
note: 'ran' is previously declared here
  ==> var.cj:18:5:
   | 
18 | let ran = 0..10 : 1
   |     ^^^ 
   | 

error: redefinition of declaration 'cls'
  ==> var.cj:23:6:
   | 
23 | let `cls` = A()
   |      ^^^ 
   | 
note: 'cls' is previously declared here
  ==> var.cj:22:5:
   | 
22 | let cls = A()
   |     ^^^ 
   | 

7 errors generated, 7 errors printed.
*/
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
