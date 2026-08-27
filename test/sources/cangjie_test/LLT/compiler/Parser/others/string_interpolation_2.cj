// ERRCHECK: %frontendCompiler %front_cmp_opt %f

main():Unit{
    let c = "${r'\h'}"
    let d = "${"\h"}"
}

/* SCAN
error: unrecognized escape '\h' in string literal
 ==> string_interpolation_2.cj:4:18:
  | 
4 |     let c = "${r'\h'}"
  |                 ~^^ unrecognized escape
  |                 |
  |                 because it is in string literal
  | 
  # note: found 12 possible escapes: '\r', '\f', '\v', '\n', '\t', '\b', '\0', '\\', '\'', '\"', '\u{__}', '\$' in string literal

error: unrecognized escape '\h' in string literal
 ==> string_interpolation_2.cj:5:17:
  | 
5 |     let d = "${"\h"}"
  |                ~^^ unrecognized escape
  |                |
  |                because it is in string literal
  | 
  # note: found 12 possible escapes: '\r', '\f', '\v', '\n', '\t', '\b', '\0', '\\', '\'', '\"', '\u{__}', '\$' in string literal

2 errors generated, 2 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
