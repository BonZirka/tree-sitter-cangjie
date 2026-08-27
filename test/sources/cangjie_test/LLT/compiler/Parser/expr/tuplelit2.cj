// ERRCHECK: %compiler %cmp_opt %f -o %output

main() {
   var x = 0
   var y = 1
   (x, ,) = (3 )
   (x, y,) = (3, 4, ,)
   println(x)
   println(y)
}

/* SCAN
error: expected expression after ',', found ','
 ==> tuplelit2.cj:6:8:
  | 
6 |    (x, ,) = (3 )
  |        ^ expected expression here
  | 

error: expected expression after ',', found ','
 ==> tuplelit2.cj:7:21:
  | 
7 |    (x, y,) = (3, 4, ,)
  |                     ^ expected expression here
  | 

2 errors generated, 2 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
