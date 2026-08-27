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
pkg classDefs: 1
pkg importedClassDefs: 1
lookup local class: MyClass
lookup iface: fail
lookup imported: ImpCls
class eq: true
imported isImported: true
*/

import stdx.chir.*

main() {
    let pkgName = "pkg.class.lookup"
    let pkg = Package(pkgName, AccessLevel.Internal)

    let localClass = pkg.addClass("mCls", "MyClass", true)
    pkg.addImportedClass("iCls", "ImpCls", "foreign.pkg", true)

    println("pkg classDefs: ${pkg.classDefs.size}")
    println("pkg importedClassDefs: ${pkg.importedClassDefs.size}")

    if (let Some(c) <- pkg.getSpecifiedClassDef(pkgName, "MyClass")) {
        println("lookup local class: ${c.srcCodeName}")
    } else {
        println("lookup local class: fail")
    }
    if (let Some(_) <- pkg.getSpecifiedClassDef(pkgName, "MyIface")) {
        println("lookup iface: ok")
    } else {
        println("lookup iface: fail")
    }
    if (let Some(ic) <- pkg.getSpecifiedClassDef("foreign.pkg", "ImpCls")) {
        println("lookup imported: ${ic.srcCodeName}")
    } else {
        println("lookup imported: fail")
    }

    if (let Some(again) <- pkg.getSpecifiedClassDef(pkgName, "MyClass")) {
        println("class eq: ${again == localClass}")
    } else {
        println("class eq: false")
    }

    if (let Some(imp) <- pkg.getSpecifiedClassDef("foreign.pkg", "ImpCls")) {
        println("imported isImported: ${imp.isImported()}")
    } else {
        println("imported isImported: false")
    }
}
