// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC: %compiler %cmp_opt %f -o %output 2>&1 | compare %f

class C1 {
    C2(){}
}
struct S3 {
    S4(){}
}
main () {

}

/* SCAN
error: expected declaration, found 'C2'
  ==> expected_primary_constructor.cj:11:5:
   | 
11 |     C2(){}
   |     ^^ expected declaration here
   | 
   # help: probably you want a primary constructor name: 'C1'

error: expected declaration, found 'S4'
  ==> expected_primary_constructor.cj:14:5:
   | 
14 |     S4(){}
   |     ^^ expected declaration here
   | 
   # help: probably you want a primary constructor name: 'S3'

2 errors generated, 2 errors printed.
*/
