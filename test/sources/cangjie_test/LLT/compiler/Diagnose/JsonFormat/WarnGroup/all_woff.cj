// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC: %compiler --diagnostic-format=json -Woff all %n.cj 2>&1 | compare %f
// ASSERT: scan-not Warnings
// ASSERT: scan-not warning

let a = 0

main() {
    let small16: Float16 = 5.9604E-8
    func g() {
        var x = {=> a}
    }
    let a = true
    0
}
