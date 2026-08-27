// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %frontendCompiler %cmp_opt %enableCompileDebug %f -o %n.%suffix -Woff unused %diag_json

var a: Int64 = 81

func foo() {
    var b = 64
    var c = 67
    var d = a >> b
    var e = a >> c
}

main(): Int64 {
    0
}
// ASSERT: scan-2 chir_shift_length_overflow
