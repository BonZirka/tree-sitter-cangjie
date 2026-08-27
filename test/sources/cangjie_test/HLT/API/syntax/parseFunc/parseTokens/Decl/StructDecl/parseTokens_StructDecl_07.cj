/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 2
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output 
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import std.unittest.*
import std.unittest.testmacro.*
import stdx.syntax.*

main() {
    let _quote = quote(@!Anno1
@!Anno1
struct s1<T> <: I1<T> & I2<T> & I3<T> {
})
    let res = parseTokens(_quote, refreshPos: false)
    let sourceNode: SyntaxTreeNode = res.node.getOrThrow()

    var structDecl: StructDecl = (sourceNode as StructDecl).getOrThrow()
    @Expect(structDecl.toString(), ##"@!Anno1
@!Anno1
struct s1<T> <: I1<T> & I2<T> & I3<T> {
}"##)
    @Assert(structDecl.body.memberDecls.size, 0)

    @Assert(structDecl.name, "s1")
    @Assert(structDecl.modifiers.size, 0)
    @Assert(structDecl.genericConstraints.isNone())
    @Assert(structDecl.genericParams.size, 1)
    @Assert(structDecl.genericParams[0].toString(), "T")
    @Assert(structDecl.superTyAnnotations.size, 3)
    @Assert(structDecl.superTyAnnotations[0].toString(), "I1<T>")
    @Assert(structDecl.superTyAnnotations[1].toString(), "I2<T>")
    @Assert(structDecl.superTyAnnotations[2].toString(), "I3<T>")
    @Assert(structDecl.annotations.size, 2)
}
