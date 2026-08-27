/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: file001.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC-PIPE: %run_stdx %output %run_utest_opt %run_args | compare %f
// ASSERT: scan possibly confusing line terminator

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_file_001() {
    let res = parseFile("./file001.cj")
    var diags = res.diags
    @Assert(diags.size, 1)
    match (diags[0].diagInfo) {
        case DiagnosticInfo.Warning(a, b) =>
            println(a);
            println(b)
        case _ => ()
    }

    let sourcefile: SourceFile = res.node.getOrThrow()
    let str = ##"package a.b.c

let v0: Int32 = 0

func foo<T>(a1: T) {
    let v1 = 1
    func inner() {
        return v1
    }
    let a = 1
 + v1
    a1
}

main() {
    let a = foo<Int64>(0)
    a + 100
    return a
}"##
    //@Assert(sourcefile.toString().replace("\n",""), str.replace("\n",""))
    @Assert(sourcefile.toTokens().toString().replace("\r",""), ##"/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package a.b.c

let v0: Int32 = 0

func foo < T >(a1: T) {
    let v1 = 1
    func inner() {
        return v1
    }
    let a = 1
    + v1
    a1
}

main() {
    let a = foo < Int64 >(0)
    a + 100
    return a
}"##)
    @Assert(sourcefile.name, "file001.cj")
    println(sourcefile.path)
    @Assert(sourcefile.path.contains("file001.cj"))
    @Assert(sourcefile.pkgHeader.isSome())
    let pkgHeader = sourcefile.pkgHeader.getOrThrow()
    @Assert(pkgHeader.accessModifier.isNone())
    @Assert(pkgHeader.isMacroPkg, false)
    @Assert(pkgHeader.packageNameIdentifiers, ["a", "b", "c"])
    @Assert(sourcefile.topLevelDecls.size, 3)
}
}