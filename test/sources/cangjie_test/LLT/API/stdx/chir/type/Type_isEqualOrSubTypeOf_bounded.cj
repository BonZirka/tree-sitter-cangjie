/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %import-cangjie-stdx %cmp_opt -o %n.%suffix %f
// RUN-EXEC: %set_stdx_path %run %run_opt %n.%suffix %run_args | compare %f
// 泛型上界：形参 T <: 上界；满足继承的实例类型 <: 上界；与上界无关的具体类型为 false

/* SCAN
T sub class bound: true
subOk sub class bound: true
plain sub class bound: false
T sub iface bound: true
impl sub iface bound: true
orphan sub iface bound: false
*/

import stdx.chir.*

main() {
    let pkg = Package("pkg.sub.bnd", AccessLevel.Public)

    let boundCls = pkg.addClass("mBdCls", "BdCls", true)
    let gCls = GenericType.get("idSubBCls", "T")
    gCls.upperBounds = Array<Type>(1, { _ => boundCls.classType })
    println("T sub class bound: ${gCls.isEqualOrSubTypeOf(boundCls.classType)}")

    let subOk = pkg.addClass("mSubOkB", "SubOkB", true)
    subOk.superClass = Some(boundCls.classType)
    println("subOk sub class bound: ${subOk.ty.isEqualOrSubTypeOf(boundCls.classType)}")

    let plain = pkg.addClass("mPlainB", "PlainB", true)
    println("plain sub class bound: ${plain.ty.isEqualOrSubTypeOf(boundCls.classType)}")

    let iface = pkg.addClass("mIFbd", "IFbd", false)
    let gIf = GenericType.get("idSubBIf", "U")
    gIf.upperBounds = Array<Type>(1, { _ => RefType.get(iface.classType) })
    println("T sub iface bound: ${gIf.isEqualOrSubTypeOf(RefType.get(iface.classType))}")

    let impl = pkg.addClass("mImplIF", "ImplIF", true)
    impl.implementedInterfaceTypes = [iface.classType]
    println("impl sub iface bound: ${impl.ty.isEqualOrSubTypeOf(RefType.get(iface.classType))}")

    let orphan = pkg.addClass("mOrph", "Orph", true)
    println("orphan sub iface bound: ${orphan.ty.isEqualOrSubTypeOf(RefType.get(iface.classType))}")
}
