// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// EXEC: %compiler %cmp_opt --int-overflow=wrapping %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

var c: Int32 = 0
var b: Int32 = R().a()

struct R {
    public func a(): Int32 {
        return 10
    }
    public func a1(p0: Int32, p1: Int32): Unit {
        c = p0 + p1
    }
    public func a2(p0: Int32, p1: Int32, p2: Int32): Unit {
        c = p0 + p1 + p2
    }
    public func a3(p0: Int32, p1: Int32, p2: Int32, p3: Int32, p4: Int32): Unit {
        c = p0 + p1 + p2 + p3 + p4
    }
    public func a4(p0: Int32, p1: Int32, p2: Int32, p3: Int32, p4: Int32, p5: Int32, p6: Int32): Unit {
        c = p0 + p1 + p2 + p3 + p4 + p5 + p6
    }
}

main(): Int64 {
    R().a1(2, 2)
    R().a2(2, 2, 2)
    R().a3(2, 2, 2, 2, 2)
    R().a4(2, 2, 2, 2, 2, 2, 2)
    if (c == b + 4) {
        return 0
    }
    return 1
}
