// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

public extend foo{
}

/* SCAN
error: expected no modifier before extend declaration, found 'public'
  ==> extern_decl.cj:10:1:
   | 
10 | public extend foo{
   | ^^^^^^ ~~~~~~ before extend declaration
   | |
   | expected no modifier here
   | 

1 error generated, 1 error printed.
*/
