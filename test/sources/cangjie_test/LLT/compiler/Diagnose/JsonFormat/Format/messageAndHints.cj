// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC: %compiler --diagnostic-format=json %n.cj 2>&1 | compare %f

main () {
    let a => class C {}
}
// ASSERT: scan parse_expected_one_of_type_or_initializer
// ASSERT: scan parse_expected_character
// ASSERT: scan parse_unexpected_declaration_in_scope
