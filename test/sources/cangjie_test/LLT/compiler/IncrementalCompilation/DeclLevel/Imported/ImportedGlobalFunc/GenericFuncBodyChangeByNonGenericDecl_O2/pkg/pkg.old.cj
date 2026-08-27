package pkg

public const y = 1
@Frozen
public func g() { 2 }
@Frozen
public func genericF<T>(): Int64 {
    println("genericF result is " + g().toString())
    return 0
}
@Frozen
public func genericG<T>(): Int64 {
    println("genericF result is " + y.toString())
    return 0
}

// ASSERT: scan genericF result is 2
// ASSERT: scan genericF result is 1


// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
