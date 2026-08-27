// EXEC-PIPE-1: %compiler %cmp_opt_chir2hlir %noColor %f -o %output 2>&1 | compare %f

foreign func PlusOne(ptr: CPointer<Int32>): Unit

main() {
    unsafe { PlusOne(inout) }
}

/* SCAN
error: expected expression after keyword 'inout', found ')'
 ==> inout_e0.cj:6:27:
  | 
6 |     unsafe { PlusOne(inout) }
  |                           ^ expected expression here
  | 

1 error generated, 1 error printed.
*/
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
