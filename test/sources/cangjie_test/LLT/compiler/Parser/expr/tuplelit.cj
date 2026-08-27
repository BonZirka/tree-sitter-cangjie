// ERRCHECK: %compiler %cmp_opt %f -o %output

main() {
   var x = 0
   var y = 1
   // a tuple is of at least two dimensions
   (x, ) = (3, ) //err
   (x, y,) = (3, 4, ) // ok
   println(x)
   println(y)
}

/* SCAN
error: expected expression after ',', found ')'
 ==> tuplelit.cj:7:8:
  | 
7 |    (x, ) = (3, ) //err
  |        ^ expected expression here
  | 

error: expected expression after ',', found ')'
 ==> tuplelit.cj:7:16:
  | 
7 |    (x, ) = (3, ) //err
  |                ^ expected expression here
  | 

2 errors generated, 2 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
