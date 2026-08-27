// EXEC: %frontendCompiler %dump-parse %cmp_opt %f 2>&1 > %redirectNull | compare %f

main():Unit{
    var a<a>.b<b>.c<c>(x) = y
}

/* SCAN
error: unexpected '<' in enum pattern
 ==> var_pattern_enum_pattern_generic_1.cj:4:10:
  | 
4 |     var a<a>.b<b>.c<c>(x) = y
  |          ^ unexpected '<'
  | 

error: unexpected '<' in enum pattern
 ==> var_pattern_enum_pattern_generic_1.cj:4:20:
  | 
4 |     var a<a>.b<b>.c<c>(x) = y
  |                    ^ unexpected '<'
  | 

2 errors generated, 2 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
