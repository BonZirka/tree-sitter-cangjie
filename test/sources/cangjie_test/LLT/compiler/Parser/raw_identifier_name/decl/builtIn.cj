// EXEC: %compiler %noColor %n.cj 2>&1 | compare %f

let arr = Array<Int64>()
let `arr` = Array<Int64>()

let point= CPointer<Int8>()
let `point` = CPointer<Int8>()


var cs: CString = CString(CPointer<UInt8>())
var `cs`: CString = CString(CPointer<UInt8>())

main() {
    0
}

/* SCAN
error: redefinition of declaration 'arr'
 ==> builtIn.cj:4:6:
  | 
4 | let `arr` = Array<Int64>()
  |      ^^^ 
  | 
note: 'arr' is previously declared here
 ==> builtIn.cj:3:5:
  | 
3 | let arr = Array<Int64>()
  |     ^^^ 
  | 

error: redefinition of declaration 'point'
 ==> builtIn.cj:7:6:
  | 
7 | let `point` = CPointer<Int8>()
  |      ^^^^^ 
  | 
note: 'point' is previously declared here
 ==> builtIn.cj:6:5:
  | 
6 | let point= CPointer<Int8>()
  |     ^^^^^ 
  | 

error: redefinition of declaration 'cs'
  ==> builtIn.cj:11:6:
   | 
11 | var `cs`: CString = CString(CPointer<UInt8>())
   |      ^^ 
   | 
note: 'cs' is previously declared here
  ==> builtIn.cj:10:5:
   | 
10 | var cs: CString = CString(CPointer<UInt8>())
   |     ^^ 
   | 

3 errors generated, 3 errors printed.
*/
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
