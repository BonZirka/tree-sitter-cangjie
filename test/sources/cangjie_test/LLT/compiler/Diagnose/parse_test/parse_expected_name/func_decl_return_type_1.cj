// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

func foo(a:b): var  {}

/* SCAN
error: expected a type name after ':' in function declaration, found keyword 'var'
  ==> func_decl_return_type_1.cj:10:16:
   | 
10 | func foo(a:b): var  {}
   |              ~ ^^^ expected a type name here
   |              |
   |              after ':' in function declaration
   | 
help: you could escape keyword as a type name using '`':
   | 
10 | func foo(a:b): `var`  {}
   |                ~~~~~ 
   | 

1 error generated, 1 error printed.
*/
