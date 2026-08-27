// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// EXEC: %compiler %cmp_opt --int-overflow=wrapping %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

var c: Int32 = 0

func func0(a: Int32): Int32 {
    return c + 10 + a
}

struct R {
    public var b0: Int32 = 1
    public var b1: Int32 = 1
    public var b2: Int32 = 1
    public var b3: Int32 = 1
    public var b4: Int32 = 1
    public var b5: Int32 = 1
    public var b6: Int32 = 1
    public var b7: Int32 = 1

    public init() {
        c = b0 + b1 + b2 + b3 + b4 + b5 + b6 + b7
    }

    public init(a: Int32) {
        this()
        c = func0(a)
    }
}

main(): Int64 {
    R(2)
    if (c == 20) {
        return 0
    }
    return 1
}
