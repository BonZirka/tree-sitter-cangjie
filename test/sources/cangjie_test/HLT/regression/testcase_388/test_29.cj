/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// EXEC-PIPE-1: %compiler %cmp_opt %f 2>&1 | compare %f



interface A<T> where T<:B<T>{}
interface B<T> where T<:A<T>{}

open class C<T> t %f -o %output

interface A<T> where T<:B<T>{}
interface B<T> where T<: A<C<T>> &B<C<T>>{}

class D <: C<D>{}

main(){
    return 0
// ASSERT: scan parse_expected_lt_brace
// ASSERT: scan parse_expected_left_brace
// ASSERT: scan parse_expected_right_delimiter
