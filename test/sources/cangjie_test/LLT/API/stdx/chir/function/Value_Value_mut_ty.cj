/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %import-cangjie-stdx %cmp_opt -o %n.%suffix %f
// RUN-EXEC: %set_stdx_path %run %run_opt %n.%suffix %run_args | compare %f
// Value.mut prop ty（GlobalVar）

/* SCAN
ty reassign: true
*/

import stdx.chir.*

main() {
    let i32 = IntType.getInt32()
    let i64 = IntType.getInt64()
    let pkg = Package("pkg.ty", AccessLevel.Public)
    let gv = pkg.addGlobalVar(i32, "v", "v", "pkg.ty")
    gv.ty = i64
    println("ty reassign: ${gv.ty == i64}")
}
