/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: class03.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

public class MyVisitor_nochange <: ASTVisitor {
    public override func preAction(node: SyntaxTreeNode): PreActionMode {
        return PreActionMode.Continue
    }

    override public func postAction(node: SyntaxTreeNode): PostActionMode {
        return PostActionMode.Continue
    }
}

public class MyRewriter_nochange <: ASTRewriter {
    public var _file : ?SourceFile = None

    override public func rewrite(node: SyntaxTreeNode): SyntaxTreeNode {
        if (let decl : SourceFile <- node) {
            _file = decl
        }
        return node
    }
}

@Test
class test_01{
    @TestCase
    func test_ASTVistor_01() {
        let filedecl = parseFile("class03.cj").node.getOrThrow()
        let _visitor = MyVisitor_nochange()
        _visitor.walk(filedecl)   
    }
}
@Test
class test_02{
    @TestCase
    func test_ASTRewriter_01() {
        let filedecl = parseFile("class03.cj").node.getOrThrow()
        let _visitor = MyRewriter_nochange()
        _visitor.walk(filedecl)   
    }
}