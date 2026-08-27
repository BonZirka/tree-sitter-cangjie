/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// LEVEL: 1
// EXEC: %compiler %import-cangjie-stdx %syntax_extra_options %cmp_opt %f -o %output %cmp_utest_opt
// RUN-EXEC: %run_stdx %output %run_utest_opt %run_args

import stdx.syntax.*

@Test
class test_01{
    @TestCase
func test_SynchronizedExpr_01() {
    let str_1 = ##"synchronized(m) {
    }"##
    let res_1 = parseText(str_1)

    let str_2 = ##"synchronized(m) {
        foo()
    }"##
    let res_2 = parseText(str_2)

    var expr_1: SynchronizedExpr = (res_1.node.getOrThrow() as SynchronizedExpr).getOrThrow()
    @Assert(expr_1.toString().replace("\r",""), ##"synchronized(m) {
    }"##)
    @Assert(expr_1.block.toString().replace("\r",""), ##"{
    }"##)
    @Assert(expr_1.structuredMutex.toString(), "m")

    var expr_2: SynchronizedExpr = (res_2.node.getOrThrow() as SynchronizedExpr).getOrThrow()
    @Assert(expr_2.toString().replace("\r",""), ##"synchronized(m) {
        foo()
    }"##)
    @Assert(expr_2.block.toString().replace("\r",""), ##"{
        foo()
    }"##)
    @Assert(expr_2.structuredMutex.toString(), "m")

    var pos = expr_2.getLParenPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 13i32, 1i32, 14i32])
    pos = expr_2.getRParenPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 15i32, 1i32, 16i32])
    pos = expr_2.getSynchronizedKeyWordPos()
    @Assert([pos.beginLine, pos.beginColumn, pos.endLine, pos.endColumn], [1i32, 1i32, 1i32, 13i32])
}
}