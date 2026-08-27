// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// (CJNATIVE) EXEC: %compiler --diagnostic-format=json -Woff semantics %n.cj 2>&1 | compare %f
// ASSERT: scan-not "WarnGroup": "semantics"

var a = 1

main() {
    func g() {
        var x = {=> a}
    }
    let a = true
    println(a)
    g()
}
