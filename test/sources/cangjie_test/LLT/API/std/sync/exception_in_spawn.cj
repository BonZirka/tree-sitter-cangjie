/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %cmp_opt %f -o %n.%suffix
// EXEC-PIPE: %run %run_opt %n.%suffix 2>&1 | compare %f
// ASSERT: scan Exception

internal import std.time.*
internal import std.sync.*

main() {
    spawn {throw Exception()}
    sleep(Duration.second)
    return 0
}
