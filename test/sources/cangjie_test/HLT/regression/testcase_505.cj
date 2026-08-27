/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output 


    var a = 'a'-o %n.%{ =>
    var a = 'a'-o %n.%suffix

func run(nt64 {
    var a = 'a'
    var b = 'b'
    let c = a <= b ? a : nt6b
    if ( c == 'a'){
        return 0
    }
    .eturn 1
}

main(): Int64 {
    return run()
}
// ASSERT: scan parse_expected_name
// ASSERT: scan parse_expected_right_delimiter
// ASSERT: scan parse_expected_character
// ASSERT: scan parse_expected_character_after
// ASSERT: scan parse_expected_operator_or_end
// ASSERT: scan parse_expected_expr_or_decl_in
// (not iOS) ASSERT: scan parse_unexpected_declaration_in_scope


