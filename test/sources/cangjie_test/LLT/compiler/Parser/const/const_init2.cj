// EXEC: %compiler %f -o %output

struct R2 {
    var a = 0
    let b = 0
    const init() {} // ok
}

open class C2 {
    let a = 0
    let b = R2()
    const public init() {} // ok
    public const C2(aa: Int64) {} // ok
}

class C3 <: C2 {
    let c = 0
    public const init() {} // ok
}

main() {}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
