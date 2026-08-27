// EXEC: %compiler %noColor %n.cj 2>&1 | compare %f

var va: VArray<Int64, $3> = [1, 2, 3]
var `va`: VArray<Int64, $3> = [1, 2, 3]

main() {
    0
}

/* SCAN
error: redefinition of declaration 'va'
 ==> builtIn_varray.cj:4:6:
  | 
4 | var `va`: VArray<Int64, $3> = [1, 2, 3]
  |      ^^ 
  | 
note: 'va' is previously declared here
 ==> builtIn_varray.cj:3:5:
  | 
3 | var va: VArray<Int64, $3> = [1, 2, 3]
  |     ^^ 
  | 

1 error generated, 1 error printed.
*/
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
