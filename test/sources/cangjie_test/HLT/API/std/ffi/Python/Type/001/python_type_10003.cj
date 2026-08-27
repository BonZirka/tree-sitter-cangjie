/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 3
// EXEC: %compiler %cmp_opt %link-python %f -o %output
// RUN-EXEC: %export cjStackSize=1MB && %run %run_opt %output %run_args

import std.ffi.python.*
import std.log.*
import std.math.*

var i = Python.load(loglevel: INFO)

main(): Int64 {
    let testcases = [UInt8.Min, 0u8, UInt8.Max]
    for (x in testcases) {
        if (UInt8(x.toPyObj().toCjObj()) != x) {
            println(x)
            throw Exception("not equal")
        }
    }
    Python.unload()
    return 0
}
