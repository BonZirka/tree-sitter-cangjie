// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// (DEBUG_OPTION)EXEC: %compiler %cmp_opt %debugCHIROpt --fchir-function-inlining %n.cj -o %output | compare %f
// ASSERT: scan [CallGraphAnalysis] Call Graph found _CN7default6<main>Hv, DIRECT CALL:_CN7default3fibHi
// ASSERT: scan [CallGraphAnalysis] Call Graph found _CN7default3fibHi, DIRECT CALL:_CN7default3fooHi
// ASSERT: scan [CallGraphAnalysis] Call Graph found _CN7default3fooHi, DIRECT CALL:_CN7default3fibHi, DIRECT CALL:_CN7default3fibHi

func fib(a: Int32): Int32 {
    if (a == 0) {
        return 0
    }
    if ((a == 1) || (a == 2)) {
        return 1
    }
    return foo(a)
}

func foo(a: Int32): Int32 {
    return fib(a - 1) + fib(a - 2)
}

main(): Int32 {
    fib(5)
}
