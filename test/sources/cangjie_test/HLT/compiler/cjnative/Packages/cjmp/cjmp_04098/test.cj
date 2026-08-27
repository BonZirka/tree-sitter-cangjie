/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// DEPENDENCE: mp
// EXEC: %compiler %cmp_opt mp/test_com.cj %compile_chir_opt -o ./
// EXEC: %compiler %cmp_opt mp/test_plat.cj %compile_dylib_opt_cjmp -o ./
// EXEC: %compiler %cmp_opt %f %link_cjmp -o %output
// RUN-EXEC: %run %run_opt %output %run_args

import mp.*

main() {
    return A.p + test_com() + test_plat()
}
