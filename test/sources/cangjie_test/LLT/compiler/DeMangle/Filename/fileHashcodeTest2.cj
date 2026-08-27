// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// EXEC: %compiler %cmp_opt %f -o %output
// EXEC-PIPE-1: %run %run_opt %output %run_args 2>&1| compare %f
// ASSERT: scan at default::EntryTest::onContinue()

public struct EntryTest <: ToString {
    public EntryTest(let key: String, let value: String) {}
    private func testHashCode(): String {
        "key: ${this.key}, value: ${this.value}"
    }
    public func toString(): String {
        return testHashCode()
    }
}

// extend private function
extend EntryTest {
    private func onContinue(): Unit {
        println("EntryTest onContinue.")
        throw Exception()
    }
    public func entryContinue(): Unit {
        onContinue()
    }
}

main() {
    var et = EntryTest("root", "123456")
    et.entryContinue()
    0
}
