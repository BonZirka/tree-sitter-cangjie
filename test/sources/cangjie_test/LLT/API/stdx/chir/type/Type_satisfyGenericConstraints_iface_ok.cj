/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %import-cangjie-stdx %cmp_opt -o %n.%suffix %f
// RUN-EXEC: %set_stdx_path %run %run_opt %n.%suffix %run_args | compare %f
// 接口上界 T <: Ref(I)；实现类满足

/* SCAN
sat gen iface impl ok: true
*/

import std.collection.*
import stdx.chir.*

main() {
    let pkg = Package("pkg.satg.ifok", AccessLevel.Public)
    let iface = pkg.addClass("ifi", "Ii", false)
    let impl = pkg.addClass("imi", "Imi", true)
    impl.implementedInterfaceTypes = [iface.classType]

    let g = GenericType.get("gSatIf", "Ti")
    g.upperBounds = Array<Type>(1, { _ => RefType.get(iface.classType) })
    var m = HashMap<GenericType, Type>()
    println("sat gen iface impl ok: ${impl.ty.satisfyGenericConstraints(g, m)}")
}
