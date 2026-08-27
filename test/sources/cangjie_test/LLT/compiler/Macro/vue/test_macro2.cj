// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// DEPENDENCE: test_macro1.cj
// EXEC: %compiler %cmp_macro test_macro1.cj
// EXEC: %run_macro %compiler %cmp_opt %macro_debug %f -o %output
// EXEC-PIPE: %run %run_opt %output %run_args | compare %f
// ASSERT: regex Hello Macro!

import view.*

main(): Int64 {
    @callView(print("Hello Macro!"))
    return 0
}
