// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// (DEBUG_OPTION)EXEC-PIPE-0: %frontendCompiler %debugCHIROpt %enableCompileDebug %f -o %n.%suffix 2>&1 | compare %f
// ASSERT: regex \[ConstAnalysis\] The const value of Div at (.*) has been set to 4
// ASSERT: regex \[ConstAnalysis\] The const value of Div at (.*) has been set to 11
// ASSERT: regex \[ConstAnalysis\] The const value of Div at (.*) has been set to 556
// ASSERT: regex \[ConstAnalysis\] The const value of Div at (.*) has been set to 9

func foo() {
    var a: UInt64 = 9000
    var b: UInt64 = 1000
    var c = a / b
}

func goo() {
    var a: UInt32 = 11120
    var b: UInt32 = 20
    var c = a / b
}

func hoo() {
    var a: UInt16 = 121
    var b: UInt16 = 11
    var c = a / b
}

func koo() {
    var a: UInt8 = 12
    var b: UInt8 = 3
    var c = a / b
}

main(): Int64 {
    0
}
