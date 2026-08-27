/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %cmp_opt %stdx-package -o %output %f
// (Unix) RUN-EXEC-PIPE-0: echo "abcdefg" | %run %run_opt %output %run_args 2>&1 | compare %f
// (Windows) RUN-EXEC-PIPE-0: echo abcdefg | %run %run_opt %output %run_args 2>&1 | compare %f
// ASSERT: scan 5
// ASSERT: scan [97, 98, 99, 100, 101]

internal import std.env.*

main() {
    try {
        var arr: Array<Byte> = Array(5, repeat: 0)
        let c = getStdIn().read(arr)
        println(c)
        println(arr)
    } catch (e: NoneValueException) {
        print(e)
    }
    return 0
}
