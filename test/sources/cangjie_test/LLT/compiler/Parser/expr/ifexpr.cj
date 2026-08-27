// LEVEL: 0
// EXEC:%frontendCompiler %typecheck %cmp_opt %f 2>&1 | compare %f

func foo1(x: Int32): Int8 {
    var i: Int8 = 3
    if (x > 3:) {
        return i + 1
    } else {
        return 3 - 1
    }

}

main(): Int64 {
    var res1: Int8 = foo1(4)
    var res2: Int8 = foo1(2)

    if (res1 != 4 || res2 != 2) {
        return 1
    }
    return 0
}

func foo2() {
    if
} 

func foo3() {
    if {
        0
    }
}

/* SCAN-IN
error: expected '(' after 'if', found '}'
  ==> ifexpr.cj:26:1:
   | 
25 |     if
   |     ~~ after this
26 | } 
   | ^ expected '(' here
   | 
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
