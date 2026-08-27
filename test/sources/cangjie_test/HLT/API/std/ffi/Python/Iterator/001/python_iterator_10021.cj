/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 3
// EXEC: %compiler %cmp_opt %f %link-python -o %output
// RUN-EXEC-PIPE-1: %export cjStackSize=1MB && %run %run_opt %output %run_args | compare %f
// ASSERT: scan Unavailable PyObj given.

import std.ffi.python.*
import std.log.*
import std.collection.*

var x = Python.load()

main(): Int64 {
    var bad = PyObjIterator(Python["bad_obj"])
    for (temp in bad) {
        print(temp)
    }
    return 0
}
