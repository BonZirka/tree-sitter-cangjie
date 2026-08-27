// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// EXEC-PIPE-0: %compiler %cmp_opt %f -o %output 2>&1 | compare %f
// EXEC-PIPE-0: %run %run_opt %output %run_args


public class Base<T> {
    func foo() {
        return 0
    }
}

main() {
    var a = Base<Int64>()
    var b = Base<Int32>()
    a.foo()
    return 0
}

/* SCAN
warning: unused variable:'b'
  ==> testUnusedFunction05.cj:19:9:
   | 
19 |     var b = Base<Int32>()
   |         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

1 warning generated, 1 warning printed.
*/
