// EXEC: %compiler -Woff all %cmp_opt %f -o %output
// EXEC: %run %run_opt %output %run_args 2>&1 | compare %f

main() {
    let x = (10, 10)
    let y = match (x) {
        case (0, 0) => "zero"
        case (n1, `n2`) => "${n2} ${`n2`}" // Matched.
    }
    println(y)
}

/* SCAN
10 10
*/
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
