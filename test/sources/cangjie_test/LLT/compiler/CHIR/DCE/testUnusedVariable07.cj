// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// EXEC-PIPE-0: %compiler %cmp_opt %f -o %output 2>&1 | compare %f
// EXEC-PIPE-0: %run %run_opt %output %run_args

// global variable and const variable
let d = 1
const e = 1

func bar() {
    let b = d
    let c = b
    let x = e
    return 0
}

func bar1() {
    let b = d
    let c = b
    let x = e
    return 0
}

main() {
    bar()
    bar1()
    return 0
}

/* SCAN
warning: unused variable:'c'
  ==> testUnusedVariable07.cj:16:9:
   | 
16 |     let c = b
   |         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> testUnusedVariable07.cj:17:9:
   | 
17 |     let x = e
   |         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'c'
  ==> testUnusedVariable07.cj:23:9:
   | 
23 |     let c = b
   |         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

warning: unused variable:'x'
  ==> testUnusedVariable07.cj:24:9:
   | 
24 |     let x = e
   |         ^ unused variable
   | 
   # note: this warning can be suppressed by setting the compiler option `-Woff unused`

4 warnings generated, 4 warnings printed.
*/
