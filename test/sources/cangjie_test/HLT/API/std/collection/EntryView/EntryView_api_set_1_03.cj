/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// EXEC: %compiler %cmp_opt %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

import std.collection.*

main(): Int64 {
    var hashmap = HashMap<String, String>()
    var entry = hashmap.entryView("key")
    entry.value = "value"
    var setResult = entry.value.getOrThrow()
    entry.value = "value1"
    if (setResult != "value" || hashmap.get("key").getOrThrow() != "value1") {
        return 1
    }
    return 0
}
