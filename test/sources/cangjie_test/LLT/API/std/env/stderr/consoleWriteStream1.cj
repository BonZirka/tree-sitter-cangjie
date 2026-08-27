/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC-PIPE-0: %run %run_opt %output %run_args 2>&1 | compare %f
// ASSERT: scan abcdefghij123123

internal import std.env.*

main() {
    var array: Array<UInt8> = [97, 98, 99, 100, 101, 102, 103, 104, 105, 106]
    var a = getStdErr()
    a.write(array)
    a.write("123123")
    return 0
}
