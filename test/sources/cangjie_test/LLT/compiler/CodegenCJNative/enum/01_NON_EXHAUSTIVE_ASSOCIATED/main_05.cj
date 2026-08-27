// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// EXEC: %compiler %cmp_opt %f -o %output
// EXEC-PIPE: %run %run_opt %output %run_args 2>&1 | compare %f
// ASSERT: scan AAA100true
// ASSERT: scan BBB123.456
// ASSERT: scan CCC77

enum NON_EXHAUSTIVE_ASSOCIATED { // nonref
    A(Int64, Bool) | B(Float32) | C(Int8) | ...
}

func foo(e: NON_EXHAUSTIVE_ASSOCIATED) {
    match (e) {
        case A(i64, b) =>
            print("AAA");
            print(i64);
            println(b)
        case B(f) =>
            print("BBB");
            println(f)
        case C(i8) =>
            print("CCC");
            println(i8)
        case _ => println("unknown")
    }
}

main() {
    foo(NON_EXHAUSTIVE_ASSOCIATED.A(100, true))
    foo(NON_EXHAUSTIVE_ASSOCIATED.B(123.456))
    foo(NON_EXHAUSTIVE_ASSOCIATED.C(Int8(77)))
    return 0
}
