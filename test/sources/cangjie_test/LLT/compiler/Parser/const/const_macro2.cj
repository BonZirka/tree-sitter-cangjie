// ERRCHECK: %compiler %f -o %output
macro package test
internal import std.ast.*

public const macro M(input: Tokens) {
    input
}

const macro M(input: Tokens) {
    input
}

main() {}

/* SCAN
[31merror[0m: unexpected modifier 'const' on macro declaration
 [36m==>[0m const_macro2.cj:5:8:
  [36m| [0m
[36m5[0m [36m| [0mpublic const macro M(input: Tokens) {[0m
  [36m| [0m       [31m^^^^^[0m [36m~~~~~ on macro declaration[0m
  [36m| [0m       [31m|[0m
  [36m| [0m       [31munexpected modifier[0m
  [36m| [0m

[31merror[0m: unexpected modifier 'const' on macro declaration
 [36m==>[0m const_macro2.cj:9:1:
  [36m| [0m
[36m9[0m [36m| [0mconst macro M(input: Tokens) {[0m
  [36m| [0m[31m^^^^^[0m [36m~~~~~ on macro declaration[0m
  [36m| [0m[31m|[0m
  [36m| [0m[31munexpected modifier[0m
  [36m| [0m

[31merror[0m: macro declaration must be modified with 'public'
 [36m==>[0m const_macro2.cj:9:7:
  [36m| [0m
[36m9[0m [36m| [0mconst macro M(input: Tokens) {[0m
  [36m| [0m      [31m^^^^^ expected 'public' before here[0m
  [36m| [0m

3 errors generated, 3 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
