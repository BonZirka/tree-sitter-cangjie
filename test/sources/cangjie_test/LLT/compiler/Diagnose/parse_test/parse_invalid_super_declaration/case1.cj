// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

class a <: Int64 {}

/* SCAN
error: cannot inherit from type: 'Int64'
  ==> case1.cj:10:12:
   | 
10 | class a <: Int64 {}
   |            ^^^^^ this type cannot be inherited
   | 
   # note: only class types and interface types can be subtyped

1 error generated, 1 error printed.
*/
