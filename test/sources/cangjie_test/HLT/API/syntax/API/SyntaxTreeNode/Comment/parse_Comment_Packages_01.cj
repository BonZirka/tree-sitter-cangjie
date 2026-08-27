/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// DEPENDENCE: dir001
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_comment_package_01() {
    let res = parsePackage("./dir001")
    var diags = res.diags
    @Assert(diags.size, 0)

    let _package: Package = res.node.getOrThrow()
    @Assert(_package.toString().replace("\r",""), ##"// Comment_01.cj
/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// single line comment

main() {}
// Comment_02.cj
/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package default

/*
    block comment
*/

class A {}"##)
    @Assert(_package.isMacroPkg, false)
    @Assert(_package.name, "default")
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

// single line comment

main() {}"##
    @Assert(file1.toString().replace("\n","").replace("\r",""), str1.replace("\n",""))
    @Assert(file1.importLists.size, 0)
    @Assert(file1.name, "Comment_01.cj")
    println(file1.path)
    @Assert(file1.path.contains("Comment_01.cj"))
    @Assert(file1.topLevelDecls.size, 1)
    @Assert(file1.comments[1].toString(), ##"// single line comment"##)
    @Assert(file1.comments[1].content, ##"// single line comment"##)

    let str2 = ##"/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package default

/*
    block comment
*/

class A {}"##
    file2.toString() |> println
    @Assert(file2.toString().replace("\n","").replace("\r",""), str2.replace("\n",""))
    @Assert(file2.importLists.size, 0)
    @Assert(file2.name, "Comment_02.cj")
    println(file2.path)
    @Assert(file2.path.contains("Comment_02.cj"))
    @Assert(file2.pkgHeader.isSome())
    let _pkgHeader = file2.pkgHeader.getOrThrow()
    @Assert(_pkgHeader.accessModifier.isNone())
    @Assert(_pkgHeader.isMacroPkg, false)
    @Assert(_pkgHeader.packageNameIdentifiers, ["default"])
    @Assert(file2.topLevelDecls.size, 1)
    @Assert(file2.comments.size, 1)
}
}