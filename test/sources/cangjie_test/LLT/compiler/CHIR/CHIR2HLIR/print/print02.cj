// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC: %compiler %cmp_opt %enableCompileDebug %f -o %n.%suffix
// EXEC: %run %run_opt %n.%suffix
// ASSERT: scan 6

class Cls2 {
    public var i6: Int64 = 6
    public func C2F0() {
        return i6
    }
}

main(): Int64 {
    var t: Cls2 = Cls2()
    print(t.C2F0().toString())
    0
}

// ASSERT: regex-not core dumped
// ASSERT: regex-not stack trace
