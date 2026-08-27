// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC: %compiler %f -o %n.%suffix
// EXEC: %run %run_opt %n.%suffix

public interface I1 {
    public func some() {
        1
    }
}

public open class A {
    public func some() {
        0
    }
}

public class B <: A {}

extend B <: I1 {}

main() {
    B().some()
}
