/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC-PIPE: %compiler %import-cangjie-stdx %cmp_opt  %f -o %output
// RUN-EXEC-PIPE: %run_stdx %output %run_args

import stdx.serialization.serialization.*
import std.math.*
import stdx.encoding.json.*

class TestJsonNull {
    public func testjsonnull(): Int64 {
        let jsonnull = JsonNull()
        let tostring = jsonnull.toString()
        let tojsonstring = jsonnull.toJsonString()
        if (!(jsonnull is JsonNull)) {
            return 1
        }
        if (tostring != "null" || tojsonstring != "null") {
            println("tostring=" + tostring)
            println("tojsonstring=" + tojsonstring)
            return 2
        }
        return 0
    }
}

main(): Int64 {
    return TestJsonNull().testjsonnull()
}
