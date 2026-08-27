// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

class foo<>  {}

/* SCAN
error: expected a generic type name after '<' in generic, found '>'
  ==> generic_decl_1.cj:10:11:
   | 
10 | class foo<>  {}
   |          ~^ expected a generic type name here
   |          |
   |          after '<' in generic
   | 

1 error generated, 1 error printed.
*/
