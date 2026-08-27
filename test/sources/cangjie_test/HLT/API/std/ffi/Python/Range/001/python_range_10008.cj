/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 3
// EXEC: %compiler %cmp_opt %f %link-python -o %output
// RUN-EXEC-PIPE: %export cjStackSize=1MB && %run %run_opt %output %run_args | compare %f
// ASSERT: scan slice(1, 10, 1)

import std.ffi.python.*
import std.log.*
import std.collection.*

var x = Python.load()

main(): Int64 {
    var i: Range<Int16> = 1..10
    var a = PySlice(i)
    println(a)
    Python.unload()
    return 0
}
