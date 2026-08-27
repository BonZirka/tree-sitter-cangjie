/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: dir001
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC-PIPE: %run_stdx %output %run_utest_opt %run_args | compare %f
// ASSERT: scan possibly confusing line terminator
// ASSERT: scan let a1 = 1
// ASSERT: scan let a2 = a1 + 1

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_dir_001() {
    let res = parsePackage("./dir001")
    var diags = res.diags
    @Assert(diags.size, 2)
    match (diags[0].diagInfo) {
        case DiagnosticInfo.Warning(a, b) =>
            println(a);
            println(b)
        case _ => ()
    }
    match (diags[1].diagInfo) {
        case DiagnosticInfo.Warning(a, b) =>
            println(a);
            println(b)
        case _ => ()
    }

    let _package: Package = res.node.getOrThrow()
    let str = ##"// file_001.cj
/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package a.b.ccc

let a1 = 1
+ 1
// file_002.cj
/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package a.b.ccc

let a2 = a1 + 1
+ 1234"##
    _package.toTokens().toString() |> println
    @Assert(_package.toTokens().toString().replace("\r",""), ##"
// file_001.cj
 /*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package a.b.ccc

let a1 = 1
+ 1 
// file_002.cj
 /*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package a.b.ccc

let a2 = a1 + 1
+ 1234"##)
    @Assert(_package.isMacroPkg, false)
    @Assert(_package.name, "a.b.ccc")
    @Assert(_package.srcFile.size, 2)
    let file1 = _package.srcFile[0]
    let file2 = _package.srcFile[1]

    let str1 = ##"/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package a.b.ccc

let a1 = 1
+ 1"##
    @Assert(file1.importLists.size, 0)
    @Assert(file1.name, "file_001.cj")
    println(file1.path)
    @Assert(file1.path.contains("file_001.cj"))
    @Assert(file1.pkgHeader.isSome())
    let pkgHeader = file1.pkgHeader.getOrThrow()
    @Assert(pkgHeader.accessModifier.isNone())
    @Assert(pkgHeader.isMacroPkg, false)
    @Assert(pkgHeader.packageNameIdentifiers, ["a", "b", "ccc"])
    @Assert(file1.topLevelDecls.size, 1)

    let str2 = ##"/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package a.b.ccc

let a2 = a1 + 1
+ 1234"##
    @Assert(file2.importLists.size, 0)
    @Assert(file2.name, "file_002.cj")
    println(file2.path)
    @Assert(file2.path.contains("file_002.cj"))
    @Assert(file2.pkgHeader.isSome())
    let _pkgHeader = file2.pkgHeader.getOrThrow()
    @Assert(_pkgHeader.accessModifier.isNone())
    @Assert(_pkgHeader.isMacroPkg, false)
    @Assert(_pkgHeader.packageNameIdentifiers, ["a", "b", "ccc"])
    @Assert(file2.topLevelDecls.size, 1)
}
}