package inc

public class C {
    public let a: (Int32, Int64) = (3,0)
    public let b: ?Int64 = Option<Int64>.Some(0)
    public let c: (Int64) -> Int64 = { _ => 0 }
    public var d: Array<Int32> = [3,4,8]
}

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
