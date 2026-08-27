// EXEC: %frontendCompiler %cmp_opt %dump-parse %f -o %output 2>&1 >%redirectNull | compare %f

main():Unit{
    if((_, _)){

    }
}

/* SCAN-IN
error: unexpected _ wildcard
 ==> tuple_wildcard_single.cj:4:9:
  | 
4 |     if((_, _)){
  |         ^ expected expression, found wildcard
  | 

error: unexpected _ wildcard
 ==> tuple_wildcard_single.cj:4:12:
  | 
4 |     if((_, _)){
  |            ^ expected expression, found wildcard
  | 

*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
