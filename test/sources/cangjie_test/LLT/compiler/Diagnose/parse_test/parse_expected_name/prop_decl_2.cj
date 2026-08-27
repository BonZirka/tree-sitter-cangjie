// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

class a {
    prop 1
}

/* SCAN
error: expected a property name after keyword 'prop' in property definition, found literal '1'
  ==> prop_decl_2.cj:11:10:
   | 
11 |     prop 1
   |     ~~~~ ^ expected a property name here
   |     |
   |     after keyword 'prop' in property definition
   | 

1 error generated, 1 error printed.
*/
