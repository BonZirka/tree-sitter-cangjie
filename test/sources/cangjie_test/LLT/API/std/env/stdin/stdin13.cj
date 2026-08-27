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
// ASSERT: scan NoneValueException
internal import std.env.*

main() {
    try {
        let c = getStdIn().readUntil(r'h')
        let r = getStdIn().readln().getOrThrow()
        if (r == String()) {
            print("success")
        }
    } catch (e: NoneValueException) {
        print(e)
    }

    return 0
}
