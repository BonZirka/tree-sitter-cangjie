// EXEC: %compiler %noColor %n.cj 2>&1 | compare %f

func add(a: Int64, `a`: Int64){}

main() {
    0
}

/* SCAN
error: redefinition of declaration 'a'
 ==> func_param.cj:3:21:
  | 
3 | func add(a: Int64, `a`: Int64){}
  |                     ^ 
  | 
note: 'a' is previously declared here
 ==> func_param.cj:3:10:
  | 
3 | func add(a: Int64, `a`: Int64){}
  |          ^ 
  | 

1 error generated, 1 error printed.
*/
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
