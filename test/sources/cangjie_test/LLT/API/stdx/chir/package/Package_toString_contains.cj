/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %import-cangjie-stdx %cmp_opt -o %n.%suffix %f
// RUN-EXEC: %set_stdx_path %run %run_opt %n.%suffix %run_args | compare %f

/* SCAN
toString has name: true
toString has access: true
*/

import stdx.chir.*

main() {
    let pkg = Package("pkg.chir.tostr", AccessLevel.Public)
    let s = pkg.toString()
    println("toString has name: ${s.contains("package: pkg.chir.tostr")}")
    println("toString has access: ${s.contains("packageAccessLevel: public")}")
}
