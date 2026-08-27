/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %cmp_opt %stdx-package -o %output %f
// RUN-EXEC-PIPE-0: %run %run_opt %output %run_args 2>&1 | compare %f
// ASSERT: scan-4097 *

/*
 * Test description:This test case is designed to test the hard-to-reach branches of the code.
 * Test API:  public func write(str: String): Int64
 */

internal import std.console.*

main() {
    var str = ""
    for (i in 0..4097) {
        str += "*"
    }
    var consoleWriteStream = Console.stdOut
    var writeLen = consoleWriteStream.write(str)
    return 0
}
