/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC: %compiler %cmp_opt -o %output %f
// RUN-EXEC-PIPE-0: echo \0 > input.txt && %run %run_opt %output %run_args < input.txt 2>&1  | compare %f
// (not Windows and not OHOS and not iOS)ASSERT: scan Some(0)
// (iOS) ASSERT: scan None
// (Windows and not OHOS)ASSERT: scan Some(\)
// (OHOS)ASSERT: scan Some(/)
import std.console.*

main() {
    let c = Console.stdIn.read()
    println(c)
    return 0
}
