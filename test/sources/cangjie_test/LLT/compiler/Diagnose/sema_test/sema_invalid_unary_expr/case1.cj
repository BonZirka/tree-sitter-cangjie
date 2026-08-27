// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f -o %output 2>&1 | compare %f

interface R {}

class C <: R {
    public operator func !(): R {
        return C()
    }
}

main() {
    !!C()
    return 0
}

/* SCAN
error: invalid unary operator '!' on type 'Interface-R'
  ==> case1.cj:19:5:
   | 
19 |     !!C()
   |     ^^^^^ 
   | 

1 error generated, 1 error printed.
*/
