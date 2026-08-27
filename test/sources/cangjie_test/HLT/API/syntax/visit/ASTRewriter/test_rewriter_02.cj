/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: class02.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

public class MyVisitor_nochange <: ASTVisitor {
    public override func preAction(node: SyntaxTreeNode): PreActionMode {
        return PreActionMode.Continue
    }

    public override func postAction(node: SyntaxTreeNode): PostActionMode {
        return PostActionMode.Continue
    }
}

@Test
class test_01 {
    @TestCase
    func test_ASTVistor_01() {
        // 目前syntax不支持Byte Literal，将导致parseFile报错
        let e = @AssertThrows[Exception](parseFile("class02.cj"))
        @Assert(e.message, "Rune Byte literal is not supported in syntax")
        // let filedecl = parseFile("class02.cj").node.getOrThrow()
        // let _visitor = MyVisitor_nochange()
        // _visitor.walk(filedecl)
    }
}
