// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC: %compiler %cmp_opt %f -o %n.%suffix
// EXEC: %run %run_opt %n.%suffix

main() {
    var s = "A"
    s + "B"
    s += "B"
    if (s != "AB") {
        return 1
    }
    return 0
}
