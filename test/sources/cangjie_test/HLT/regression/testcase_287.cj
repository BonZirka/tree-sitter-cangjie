/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f -o %output 2>&1 | compare %f



interface A<X,Y> where X<:A<X,X> & B<Y,Y>, Y<:A<Y,Y> & B<X,X>{}
interface B<X,Y> where X<:A<,X>,X,X>,X,X>,X,X>,X,X>,X,X>,X,X> & B<Y,Y>, Y<:A<Y,Y> & B<X,X>{}


class C <: A<C,C> & B<C,C>{}

main():Int64{
    return 0
}
// ASSERT: scan parse_expected_type
// ASSERT: scan parse_expected_character
// ASSERT: scan parse_expected_left_brace
