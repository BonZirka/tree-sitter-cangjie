/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output 


open class A{}
open class B <: A{}
open class C <: B{}

open class D{}
open class E <: D{}
open class F <: E{}

open class G{}
open class H <: G{}
open class I <: H{}

func f<X,Y,Z>(a: (X,Y,Z)) where X<:A,Y<:D,Z<:G{1} //F1
func f<X,Y,Z>(a: (X,Y,Z)) where X<:A,Y<:D,Z<:H{0} //F2


main()  where X<:A,Y<:D,Z<:H{0} //F2


main() {
    f((C(),F(),I()))
}
// ASSERT: scan parse_missing_body
// ASSERT: scan parse_unexpected_where
// ASSERT: scan parse_expected_character


