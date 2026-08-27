// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC: %compiler %cmp_opt %enableCompileDebug %f -o %n.%suffix
// EXEC: %run %run_opt %n.%suffix

struct RA {
    public var id: Int64 = 15
    public var age: Int64 = 40
}

struct RB {
    public var ra = RA()
}

struct RC {
    public var rb = RB()
}

main() {
    var rc = RC()
    rc.rb.ra.id = 2
    rc.rb.ra.age = 3

    return rc.rb.ra.id + rc.rb.ra.age - 5
}

// ASSERT: regex-not core dumped
// ASSERT: regex-not stack trace
