/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 0
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_FuncDecl_01() {
    let str_1 = ##"const func func_1() {}"##
    let res_1 = parseText(str_1)

    let str_2 = ##"public func func_2(a: Int64, b!: String, c!: Int64 = 0): Int64 {
    return a + c
}"##
    let res_2 = parseText(str_2)

    let str_3 = ##"protected func func_3<T, U>(a: T, b: U): T where T <: I1<T> & I2<T>, U <: I3<U> {
    a
}"##
    let res_3 = parseText(str_3)

    var funcdecl_1 = (res_1.node.getOrThrow() as FuncDecl).getOrThrow()
    @Expect(funcdecl_1.toString(), ##"const func func_1() {}"##)
    @Assert(funcdecl_1.body.isSome())
    @Assert(funcdecl_1.body.getOrThrow().toString(), "{}")
    @Assert(funcdecl_1.genericConstraints.isNone())
    @Assert(funcdecl_1.genericParams.size, 0)
    match (funcdecl_1.kind) {
        case Normal => ()
        case _ => @Assert(false)
    }
    @Assert(funcdecl_1.name, "func_1")
    @Assert(funcdecl_1.params.params.size, 0)
    @Assert(funcdecl_1.retTyAnnotation.isNone())
    @Expect(funcdecl_1.modifiers.toString(), "[const]")
    @Assert(funcdecl_1.annotations.toString(), "[]")

    var funcdecl_2 = (res_2.node.getOrThrow() as FuncDecl).getOrThrow()
    @Assert(funcdecl_2.toString().replace("\r",""), ##"public func func_2(a: Int64, b!: String, c!: Int64 = 0): Int64 {
    return a + c
}"##)
    @Assert(funcdecl_2.body.isSome())
    @Assert(funcdecl_2.body.getOrThrow().toString().replace("\r",""), ##"{
    return a + c
}"##)
    @Assert(funcdecl_2.genericConstraints.isNone())
    @Assert(funcdecl_2.genericParams.size, 0)
    match (funcdecl_2.kind) {
        case Normal => ()
        case _ => @Assert(false)
    }
    @Assert(funcdecl_2.name, "func_2")
    @Assert(funcdecl_2.params.params.size, 3)
    @Assert(funcdecl_2.params.params[0] is FuncParam)
    @Assert(funcdecl_2.params.params[1] is FuncParam)
    @Assert(funcdecl_2.params.params[2] is FuncParam)
    @Assert(funcdecl_2.params.params[0].toString(), "a: Int64")
    @Assert(funcdecl_2.params.params[1].toString(), "b!: String")
    @Assert(funcdecl_2.params.params[2].toString(), "c!: Int64 = 0")
    @Assert(funcdecl_2.retTyAnnotation.isSome())
    @Assert(funcdecl_2.retTyAnnotation.getOrThrow() is AtomicType)
    @Assert(funcdecl_2.modifiers.toString(), "[public]")
    @Assert(funcdecl_2.annotations.toString(), "[]")

    var funcdecl_3 = (res_3.node.getOrThrow() as FuncDecl).getOrThrow()
    @Assert(funcdecl_3.toString().replace("\r",""), ##"protected func func_3<T, U>(a: T, b: U): T where T <: I1<T> & I2<T>, U <: I3<U> {
    a
}"##)
    @Assert(funcdecl_3.body.isSome())
    @Assert(funcdecl_3.body.getOrThrow().toString().replace("\r",""), ##"{
    a
}"##)
    @Assert(funcdecl_3.genericConstraints.isSome())
    @Assert(funcdecl_3.genericConstraints.getOrThrow().toString(), "where T <: I1<T> & I2<T>, U <: I3<U>")
    @Assert(funcdecl_3.genericParams.size, 2)
    @Assert(funcdecl_3.genericParams[0].toString(), "T")
    @Assert(funcdecl_3.genericParams[1].toString(), "U")
    match (funcdecl_3.kind) {
        case Normal => ()
        case _ => @Assert(false)
    }
    @Assert(funcdecl_3.name, "func_3")
    @Assert(funcdecl_3.params.params.size, 2)
    @Assert(funcdecl_3.params.params[0].toString(), "a: T")
    @Assert(funcdecl_3.params.params[1].toString(), "b: U")
    @Assert(funcdecl_3.retTyAnnotation.isSome())
    @Assert(funcdecl_3.retTyAnnotation.getOrThrow() is CompositeType)
    @Assert(funcdecl_3.modifiers.toString(), "[protected]")
    @Assert(funcdecl_3.annotations.toString(), "[]")

    @Assert(funcdecl_3.getFuncKindKeyWordPos().isNone(), true)
    var pos = funcdecl_3.getFuncKeyWordPos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 11i32, 1i32, 15i32])
    var posList = funcdecl_3.getGenericParamsCommasPos()
    @Assert(posList.size == 1, true)
    @Assert([posList[0].beginLine, posList[0].beginColumn, posList[0].endLine, posList[0].endColumn], [1i32, 24i32, 1i32, 25i32])
    pos = funcdecl_3.getGenericParamsLAnglePos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 22i32, 1i32, 23i32])
    pos = funcdecl_3.getGenericParamsRAnglePos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 27i32, 1i32, 28i32])
    pos = funcdecl_3.getIdentifierPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 16i32, 1i32, 22i32])
    pos = funcdecl_3.getRetTyAnnotationColonPos().getOrThrow()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 40i32, 1i32, 41i32])
}
}