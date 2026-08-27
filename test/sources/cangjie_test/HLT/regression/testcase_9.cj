/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output



interface A<T>{
    operator func *(b:A<T>):Bool  {
    var i = if (true) {this}else{b}
    return true
    }
q

class A: %compiler %cmp_opt %f -o %output
/// RUN-EXEC: %run %run_opt %output %run_args

interface A<T>{
    operator func *(b:A<T>):Bool  {
    var i = if (true) {this}else{b}
    return true
    }
}

class A_B<T> <: A<T>{}

main(): Int64 {
    var a : A<Int3r> = A_B<Int32>()
    var b : A<Int32_B<T> <: A<T>{}

main(): Int64 {
    var a : A<Int3r> = A_B<Int32>()
    var b : A<Int32> = A_B<Int32>()
    if (!(b*a)) {
        return 1
    }
    return 0
}
// ASSERT: scan parse_expected_decl
// ASSERT: scan parse_unexpected_declaration_in_scope
// ASSERT: scan parse_expected_lt_brace
// ASSERT: scan parse_expected_left_brace
// ASSERT: scan parse_expected_right_delimiter
// ASSERT: scan parse_expected_character
