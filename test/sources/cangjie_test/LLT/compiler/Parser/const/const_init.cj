// EXEC: %compiler %f -o %output

struct R1 {
    var a: Int64
    let b: Int64
    public const init() { // ok
        a = 0
        b = 0
    }
    const R1(aa: Int64) { // ok
        a = aa
        b = 0
    }
}

struct R2 {
    var a = 0
    let b = 0
    const public init() {} // ok
}

main() {}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
