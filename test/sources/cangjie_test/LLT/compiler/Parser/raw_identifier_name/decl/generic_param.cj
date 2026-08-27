// EXEC: %compiler %noColor %n.cj 2>&1 | compare %f

struct Pair<`T`, T> {
}
main() {
    0
}

/* SCAN
error: redefinition of declaration 'T'
 ==> generic_param.cj:3:18:
  | 
3 | struct Pair<`T`, T> {
  |                  ^ 
  | 
note: 'T' is previously declared here
 ==> generic_param.cj:3:14:
  | 
3 | struct Pair<`T`, T> {
  |              ^ 
  | 

1 error generated, 1 error printed.
*/
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
