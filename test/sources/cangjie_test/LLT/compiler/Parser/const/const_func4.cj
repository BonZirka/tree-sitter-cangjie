// EXEC: %compiler %f -o %output

const func f1(a: Int64): Unit { // ok
    return
}

const public func f2(a: Int64): Unit { // ok
    return
}

public const func f3(a: Int64): Unit { // ok
    return
}

main() {}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
