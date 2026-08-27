// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// EXEC: %compiler %cmp_opt --int-overflow=wrapping %f -o %output
// RUN-EXEC: %run %run_opt %output %run_args

class A {
    public var a: Int32
    public init() {
        this.a = 1
    }
    public func test(): Int32 {
        var cnt = 0
        while (cnt < 100) {
            A()
            cnt++
        }
        return 10
    }
}

main(): Int64 {
    var num = 0
    var res: Int32 = 0
    while (num < 10) {
        var a = A()
        res = a.test()
        num++
    }
    if (num == 10 && res == 10) {
        return 0
    }
    return 1
}
