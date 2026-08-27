/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC-PIPE: %run %run_opt %output %run_args 2>&1
import std.overflow.*
import std.math.*

main() {
    let a: UInt8 = UInt8.Max
    var b = a.checkedMul(1)
    var c = a.checkedMul(2)
    var someNum = 0
    var noneNum = 0
    var res = match (b) {
        case Some(s) => someNum++
        case None => noneNum++
    }
    var res2 = match (c) {
        case Some(s) => someNum++
        case None => noneNum++
    }
    if (someNum != noneNum) {
        return 1
    }
    return 0
}
