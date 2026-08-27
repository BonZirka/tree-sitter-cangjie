interface A {}
struct V <: A & ToString {
    public func toString(): String { "" }
}
extend<T> Option<T> <: A {}
func foo(): Unit {
    let a: Any = V()
}
main(): Unit {
}

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
