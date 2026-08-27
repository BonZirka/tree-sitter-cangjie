// EXEC: %compiler %cmp_opt %f -o %output
// EXEC: %run %run_opt %output %run_args 2>&1 | compare %f
// ASSERT: regex-not error

struct `UsrTyp`{
    let a = "hello"
    let b = "world"
}

main() {
    let usrVar1 = `UsrTyp`()
    let usrVar2 = UsrTyp()
    println("${usrVar1.a} ${usrVar1.b}")
    println("${usrVar2.a} ${usrVar2.b}")
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
