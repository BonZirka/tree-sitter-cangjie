// EXEC-PIPE-1: %compiler %cmp_opt %f 2>&1 | compare %f


foreign func f()

main():Unit{

}

/* SCAN
error: foreign function must declare its return type
 ==> foreign_need_return_value.cj:4:1:
  | 
4 | foreign func f()
  | ^^^^^^^^^^^^ 
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
