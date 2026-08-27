/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// ASSERT: scan-full Compatible!\n
package test_stable_abi

public enum TestE1 {
    XY
}

extend TestE1 {
    public func f1() {
        1
    }

    protected func f2() {
        2
    }

    const func f3(): Int64 {
        return 3
    }

    public const func f4(): Int64 {
        f3()
    }
    func pf3(): Int64 {
        return 3
    }

    @Frozen
    public func pf4(): Int64 {
        pf3()
    }

    func pf5() {
        8
    }

    @Deprecated["This API is deprecated", strict: true]
    public func pf6() {
        pf5()
    }

    const func f5() {
        10
    }

    public const func f6(): Int64 {
        f5()
    }
}


