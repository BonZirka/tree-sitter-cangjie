// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// (DEBUG_OPTION)EXEC: %compiler %f -o %output %enableSwitchOpt
// (DEBUG_OPTION)EXEC-2: %run %run_opt %output
// (DEBUG_OPTION)EXEC: %frontendCompiler %dump-ir-to-screen %f %enableSwitchOpt 2>&1 | compare %f
// ASSERT: regex-1 switch i64 %\d+

main() {
    var a = 1
    match (a) {
        case 2 => 0
        case 3 => 1
        case _ => 2
        case 4 => 3
        case _ => 4
    }
}
