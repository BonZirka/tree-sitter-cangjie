// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC: %compiler %cmp_opt %enableCompileDebug %f -o %n.%suffix
// EXEC: %run %run_opt %n.%suffix

struct RA {
    public var k = 9
    public mut func foo() {
        this.k = this.k + 5
    }
}

main() {
    var ins = RA()
    ins.foo()
    ins.k - 14
}
