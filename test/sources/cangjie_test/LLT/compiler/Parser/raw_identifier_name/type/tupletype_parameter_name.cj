// EXEC: %compiler %cmp_opt %f -o %output
// EXEC: %run %run_opt %output %run_args 2>&1 | compare %f
// ASSERT: regex-not error


struct `UsrTyp`{
    let a: String = "hello"
    let b: String = "world"
}

main() {
    let usrVar = `UsrTyp`() 
    let x: (Int64, `UsrTyp`) = (3, usrVar)
    let y: (Int64, UsrTyp) = (3, usrVar)
    println("${x[1].a} ${x[1].b}")
    println("${y[1].a} ${y[1].b}")
    return 0
}

/* SCAN
hello world
hello world
*/
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
