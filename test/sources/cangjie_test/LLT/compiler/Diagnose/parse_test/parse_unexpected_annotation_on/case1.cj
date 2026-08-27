// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %f

macro package test

@C
internal import std.ast.*

@C
public macro M(a:Tokens):Tokens{
    var x = sourceFile()
    var y = sourceLine()
    return a
}

/* SCAN
error: unexpected annotation '@C' on import
  ==> case1.cj:12:1:
   | 
12 | @C
   | ^^ unexpected annotation here
13 | internal import std.ast.*
   |          ~~~~~~ on import
   | 

1 error generated, 1 error printed.
*/
