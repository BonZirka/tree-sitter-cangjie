// EXEC: %compiler %noColor %n.cj 2>&1 | compare %f

struct `UsrTyp`{
    let a: Int64 = 0
    let b: Int64 = 0
}
struct UsrTyp{
    let a: Int64 = 0
    let b: Int64 = 0
}

main() {
    0
}

/* SCAN
error: redefinition of declaration 'UsrTyp'
 ==> struct.cj:7:8:
  | 
7 | struct UsrTyp{
  |        ^^^^^^ 
  | 
note: 'UsrTyp' is previously declared here
 ==> struct.cj:3:9:
  | 
3 | struct `UsrTyp`{
  |         ^^^^^^ 
  | 

1 error generated, 1 error printed.
*/
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
