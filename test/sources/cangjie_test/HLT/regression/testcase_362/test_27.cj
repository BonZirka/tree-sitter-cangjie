/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f 2>&1 | compare %f



open class A{}
oen class B <: A{}
open class C <: B{}

open class D{}
open class E <: D{}
open clas F <: E{}

open class G{}
open class H <: G{}
open class I <: H{}

func f<X,Y,Z>(a:X*Y*Z) where X<:A,Y<:F,Z<:I{0} //F1
func f<X,Y,Z>(a:X*Y*Z) where X<:C,Y<:D,Z<:I{1} //F2
func f<X,Y,Z>(a:X*Y*Z) where X<:C,Y<:F,Z<:G{1} //F3


main() {
f((C(),F(),I()))
}
// ASSERT: scan parse_expected_decl
// ASSERT: scan parse_expected_character
// ASSERT: scan parse_expected_right_delimiter
