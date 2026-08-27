/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %cmp_opt -o %output %f
// RUN-EXEC-PIPE-0: echo "hello world" | %run %run_opt %output %run_args 2>&1 | compare %f
// ASSERT: scan Echo: hello world

main() {
    let line = readln()
    println("Echo: ${line}")
    return 0
}
