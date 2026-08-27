// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// (DEBUG_OPTION)EXEC: %compiler %debugCHIROpt %enableConstPropagation %cmp_opt %enableCompileDebug %f -o %output 2>&1 | compare %f
// (DEBUG_OPTION)RUN-EXEC: %run %output

class A {
    static let x: Int64
    static var y: Int64
    static let z: Int64

    static init() {
        x = 1
        y = x
        foo()
        z = y
    }
}

func foo() {
    0
}

main() {
    A.x + A.y + A.z
    0
}

// ASSERT: scan [ConstPropagation] The Load at [static.init02.cj,18,13] has been rewrited to a constant
// ASSERT: regex-not \[ConstPropagation\] The Load at [static\.init02\.cj,20,.*] has been rewrited to a constant
// ASSERT: scan [ConstPropagation] The Load at [static.init02.cj,29,5] has been rewrited to a constant