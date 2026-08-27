/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: pkgs pkga
// EXEC: %compiler %cmp_opt %compile_lib_opt pkgs/pkgs.cj -o pkgs.%middle
// EXEC: %compiler %cmp_opt %compile_lib_opt pkga/pkga.cj -o pkga.%middle
// EXEC-PIPE-1: %compiler %cmp_opt %f -o %output 2>&1 | compare %f

import pkgs.Data
import pkga.*

main(): Int32 {
    return run()
}

func run(): Int32 {
    var a: Int32 = 3
    var b: Int32 = 4
    let data1: pkgs.Data<Int32> = pkgs.Data<Int32>(a, b)
    let data2: Data<Int32> = Data<Int32>(b, a)
    return 0
}
// ASSERT: scan sema_ambiguous_use
// ASSERT: scan sema_ambiguous_use
