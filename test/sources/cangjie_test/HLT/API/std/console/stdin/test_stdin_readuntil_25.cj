/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// EXEC: %compiler %cmp_opt -o %output %f
// (not iOS) RUN-EXEC-PIPE-0: echo 齉龘齉齾爩麤龗灪龖厵纞虋繁齉龘齉齾爩麤龗灪龖厵纞虋繁齉龘齉齾爩麤龗灪龖厵纞虋繁 > input.txt && %run %run_opt %output %run_args < input.txt 2>&1 | compare %f
// ASSERT: scan Some(齉龘齉齾爩麤龗)

import std.console.*

func func1(c: Rune): Bool {
    return c == r'龗'
}

main() {
    let c = Console.stdIn.readUntil(func1)
    println(c)
    return 0
}
