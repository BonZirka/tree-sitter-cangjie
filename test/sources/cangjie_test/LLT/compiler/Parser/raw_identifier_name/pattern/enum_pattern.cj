// EXEC: %compiler -Woff all %cmp_opt %f -o %output
// EXEC: %run %run_opt %output %run_args 2>&1 | compare %f

enum E {
    | A(UInt64)
    | `B`(UInt64)
}

main() {
    let x = B(5)
    let var1 = match (x) {
        case E.`A`(n) => n
        case E.`B`(n) => n * 2
    }
    println(var1);
    let y = B(10)
    let var2 = match (y) {
        case E.`A`(n) => n * 2
        case E.`B`(n) => n
    }
    println(var2);
}

/* SCAN
10
10
*/
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
