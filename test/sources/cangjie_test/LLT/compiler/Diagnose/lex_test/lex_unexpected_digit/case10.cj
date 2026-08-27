// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f -o %output 2>&1 | compare %f

main(): Int64 {

    var check_value = [-10,-8,-6,-4,-2,0B2,4,6,8]
    var index = 0

    var b = -10...10:{2}

    for item in b {
        if item != check_value[index]{
            return 1
        }
        index = index + 1
    }

    return 0
}

/* SCAN
error: unexpected digit '2' in binary
  ==> case10.cj:12:42:
   | 
12 |     var check_value = [-10,-8,-6,-4,-2,0B2,4,6,8]
   |                                        ~~^ unexpected digit
   |                                        |
   |                                        because of this binary prefix
   | 
   # note: binary may only contain digit within 0~1

1 error generated, 1 error printed.
*/
