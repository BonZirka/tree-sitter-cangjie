// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC: %compiler %disableReflection %f -o %output
// EXEC-1: %run %run_opt %output

func foo() {
    var a = true
    var x = 1
    var b = while (a) {
        break
        x = x + 1
    }
    return x
}

main() {
    return foo()
}
