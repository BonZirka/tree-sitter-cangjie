/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f -o %output 2>&1 | compare %f


open class A<X,Y>{}
open class B<X,Y> <: A<X,Y>{}
open class C<X,Y> <: A<X,Y>{}

func foo<Xot core dumped
open class A<X,Y>{}
open class B<X,Y> <: A<X,Y>{}
open class C<X,Y> <: A<X,,Y>(a: B<X,Y>, b: C<X,Y>): Int64 {1} // foo1
func foo<X,Y>(a: B<Y,X>, b: C<Y,X>) :Int64 {0} // foo2


main() {
foo(B<Int32,Int64>(),C<Int32,Int64>())
}
// ASSERT: scan parse_expected_right_delimiter
// ASSERT: scan parse_expected_lt_paren
// ASSERT: scan parse_expected_type
// ASSERT: scan parse_expected_left_brace
// ASSERT: scan parse_expected_character
