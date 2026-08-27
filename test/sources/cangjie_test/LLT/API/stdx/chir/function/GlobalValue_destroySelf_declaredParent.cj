/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %import-cangjie-stdx %cmp_opt -o %n.%suffix %f
// RUN-EXEC: %set_stdx_path %run %run_opt %n.%suffix %run_args | compare %f
// GlobalValue.destroySelf：从 declaredParent 的 methods / staticVars 中移除

/* SCAN
methods before: 1
methods after: 0
method invalid: true
staticVars before: 1
staticVars after: 0
static invalid: true
*/

import stdx.chir.*

main() {
    let pkgName = "pkg.gv.parent"
    let pkg = Package(pkgName, AccessLevel.Public)
    let i32 = IntType.getInt32()

    let cls = pkg.addClass("mCls", "Cls", true)

    let mf = pkg.addFunction(FuncType.get([i32], i32), "mCls.getX", "getX", pkgName)
    mf.initBody()
    mf.body.getOrThrow().entryBlock.appendExpr(Exit.create())
    cls.appendMethod(mf)
    println("methods before: ${cls.methods.size}")
    mf.destroySelf()
    println("methods after: ${cls.methods.size}")
    println("method invalid: ${!mf.isFunction()}")

    let sv = pkg.addGlobalVar(i32, "mCls.count", "count", pkgName)
    cls.appendStaticVar(sv)
    println("staticVars before: ${cls.staticVars.size}")
    sv.destroySelf()
    println("staticVars after: ${cls.staticVars.size}")
    println("static invalid: ${!sv.isGlobalVar()}")
}
