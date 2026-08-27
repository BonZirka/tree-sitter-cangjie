// EXEC: %compiler -Woff all %cmp_opt %f -o %output
// EXEC: %run %run_opt %output %run_args 2>&1 | compare %f
// ASSERT: regex-not error

enum `RGBColor` {
    | Red | Green | Blue
}

main() {
    let r1 = RGBColor.Red
    let r2 = `RGBColor`.Red
    match (r1){
        case Red => println("Red")
        case Green => println("Green")
        case Blue => println("Blue")
    }
    match (r2){
        case Red => println("Red")
        case Green => println("Green")
        case Blue => println("Blue")
    }
    return 0
}

/* SCAN
Red
Red
*/
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
