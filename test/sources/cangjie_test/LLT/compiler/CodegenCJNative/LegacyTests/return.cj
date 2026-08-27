// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// EXEC: %compiler %cmp_opt %n.cj -o %n.%suffix
// EXEC: %run %run_opt %n.%suffix
// ASSERT: regex-not core dump
// ASSERT: regex-not stack trace

func Ret(a: Int32, b: Int32): Int32 {
    if (a > b) {
        return a
    } else if (a == b) {
        return a - b
    } else {
        return return b
        return return a
    }
    return return return return a + b
    return 11111111
}

func codegenUnitTest(): Int32 {
    return Ret(40, 30)
}

main(): Int64 {
    var ret = codegenUnitTest()
    if (ret == 40) {
        return 0
    } else {
        return -1
    }
}
