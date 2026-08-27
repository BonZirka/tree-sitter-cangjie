// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC: %compiler %cmp_opt %enableCompileDebug %f -o %n.%suffix
// EXEC: %run %run_opt %n.%suffix
// ASSERT: scan B!success!

interface A <: Resource {
    func isClosed() {
        print("A!");
        true
    }
    func close() {}
}

interface C <: A {}

class B <: C {
    public func isClosed() {
        false
    }
    public func close() {
        print("B!")
    }
}

main() {
    try (a: B = B()) {
    } finally {}
    print("success!\n")
    return 0
}
