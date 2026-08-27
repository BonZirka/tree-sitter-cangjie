/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// DEPENDENCE: GenericParam_01.cj
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_GenericParam_01() {
    let res = parseFile("./GenericParam_01.cj")
    let sourcefile: SourceFile = res.node.getOrThrow()
    @Expect(sourcefile.toString().replace("\r","").contains(##"internal class C1<T, U> <: I1<U> & I2<T, U> & I3<T> where T <: I1<T> & I3<T> , U<: I2<T, T> {
}"##))

    var classDecl: ClassDecl = (sourcefile.topLevelDecls[0] as ClassDecl).getOrThrow()
    @Assert(classDecl.toString().replace("\r",""), ##"internal class C1<T, U> <: I1<U> & I2<T, U> & I3<T> where T <: I1<T> & I3<T> , U<: I2<T, T> {
}"##)

    @Assert(classDecl.genericParams.size, 2)
    @Assert(classDecl.genericParams[0].name, "T")
    @Assert(classDecl.genericParams[0].toTokens().toString(), "T")
    @Assert(classDecl.genericParams[1].name, "U")
}
}