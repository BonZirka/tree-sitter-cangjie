// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC: %compiler --diagnostic-format=json --error-count-limit 3 %f 2>&1 | compare %f

main() {
    var a = 0
        + 1
    var a = 0
    var a = 0
    var a = 0
    var a = 0
    var a = 0
    var a = 0
    var a = 0
}

/* SCAN-IN
    "Num":{
        "Errors": 7,
        "PrintedErrors": 3,
        "Warnings": 1,
        "PrintedWarnings": 1
    }
*/
