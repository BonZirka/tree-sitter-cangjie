// ERRCHECK: %frontendCompiler %front_cmp_opt %f

main():Unit{
    let a = r'\h'
    let b = r'\$'
}

/* SCAN
error: unrecognized escape '\h' in rune literal
 ==> char_literal.cj:4:15:
  | 
4 |     let a = r'\h'
  |             ~ ^^ unrecognized escape
  |             |
  |             because it is in rune literal
  | 
  # note: found 12 possible escapes: '\r', '\f', '\v', '\n', '\t', '\b', '\0', '\\', '\'', '\"', '\u{__}', '\$' in rune literal

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
