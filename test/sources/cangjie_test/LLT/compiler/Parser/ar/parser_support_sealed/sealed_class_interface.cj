// EXEC-PIPE-1: %compiler %cmp_opt %f -o %output 2>&1 | compare %f

sealed class A {}
sealed abstract class B {}
sealed interface I {}

main() {}

/* SCAN
error: non-abstract class cannot be modified by 'sealed'
 ==> sealed_class_interface.cj:3:14:
  | 
3 | sealed class A {}
  |              ^ 
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
