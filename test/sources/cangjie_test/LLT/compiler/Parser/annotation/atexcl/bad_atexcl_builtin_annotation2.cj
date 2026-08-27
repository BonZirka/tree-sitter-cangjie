// ERRCHECK: %compiler %f %cmp_opt

@!Frozen
func bar<T>() {}

struct Counter {
    var cnt = 0
    @!Attribute[Binding] var bcnt = 0
}

/* SCAN
error: expected declaration, found '@!'
 ==> bad_atexcl_builtin_annotation2.cj:3:1:
  | 
3 | @!Frozen
  | ^^ expected declaration here
  | 
  # note: only declarations or macro expressions can be used in the top-level

error: expected declaration, found '@!'
 ==> bad_atexcl_builtin_annotation2.cj:8:5:
  | 
8 |     @!Attribute[Binding] var bcnt = 0
  |     ^^ expected declaration here
  | 

2 errors generated, 2 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
