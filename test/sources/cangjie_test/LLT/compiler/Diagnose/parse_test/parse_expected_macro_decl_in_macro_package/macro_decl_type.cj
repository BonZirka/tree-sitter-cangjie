// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// EXEC: %compiler %cmp_opt %f -o %output 2>&1 | compare %f

macro package define
import std.ast.*

public type ATokens = Tokens;

main() {
}

/* SCAN
error: cannot use 'public' on type declarations in a macro package
  ==> macro_decl_type.cj:13:1:
   | 
10 | macro package define
   | ~~~~~~~~~~~~~ macro package defined here
11 | import std.ast.*
   | ...
13 | public type ATokens = Tokens;
   | ^^^^^^ 
   | 
   # note: Declarations in 'macro package' cannot be accessed in other packages, except macro declarations.

1 error generated, 1 error printed.
*/
