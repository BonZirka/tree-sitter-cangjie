// EXEC: %compiler %cmp_opt %f -o %output 2>&1 | compare %f

main():Unit{
    Option<()>
}

/* SCAN
error: expected '->' in function type
 ==> func_type_in_generic.cj:4:14:
  | 
4 |     Option<()>
  |              ^ 
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
