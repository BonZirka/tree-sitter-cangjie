// LEVEL: 0
// EXEC: %compiler %f -o %output %cmp_opt 2>&1 | compare %f
// RUN-EXEC: %run %run_opt %output

let a = ""

main() {
    match (UInt32(a.toRuneArray()[0])) {
        case 0xf8ff => 0
        case _ => 1
    }
}
// ASSERT: scan warning: unsecure character:\\u{F8FF}

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
