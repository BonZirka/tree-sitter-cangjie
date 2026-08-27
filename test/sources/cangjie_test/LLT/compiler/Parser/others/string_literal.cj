// ERRCHECK: %frontendCompiler %front_cmp_opt %f

main():Unit{
    let a = "\h"
    let b = "\$"
}

/* SCAN
error: unrecognized escape '\h' in string literal
 ==> string_literal.cj:4:14:
  | 
4 |     let a = "\h"
  |             ~^^ unrecognized escape
  |             |
  |             because it is in string literal
  | 
  # note: found 12 possible escapes: '\r', '\f', '\v', '\n', '\t', '\b', '\0', '\\', '\'', '\"', '\u{__}', '\$' in string literal

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
