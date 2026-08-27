// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// EXEC: %cjc %compile_exe_opt %debugCHIROpt %n.cj %cmp_opt -o %output 2>&1 | compare %f
// ASSERT: scan error: an exception was thrown while evaluating constant
// ASSERT: scan ArithmeticException
// ASSERT: scan-not core dumped
// ASSERT: scan-not stack trace

@OverflowThrowing
const func testThrowingShiftRight(x: UInt16, y: UIntNative): UInt16 {
    return x >> y
}

public const my_const = testThrowingShiftRight(1, 16)

main() {
    my_const
}