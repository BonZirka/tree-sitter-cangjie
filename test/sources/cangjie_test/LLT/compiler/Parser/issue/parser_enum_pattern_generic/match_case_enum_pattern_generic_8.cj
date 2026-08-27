// EXEC: %frontendCompiler %dump-parse %cmp_opt %f 2>&1 > %redirectNull | compare %f

main():Unit{
    match(x){
        case a<a>.b.c => 1
        case _ => 2
    }
}

/* SCAN
error: unexpected '<' in enum pattern
 ==> match_case_enum_pattern_generic_8.cj:5:15:
  | 
5 |         case a<a>.b.c => 1
  |               ^ unexpected '<'
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
