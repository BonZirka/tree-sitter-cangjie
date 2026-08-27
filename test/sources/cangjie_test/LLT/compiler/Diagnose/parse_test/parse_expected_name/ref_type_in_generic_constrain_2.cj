// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

interface Enumerable<U> where <: {}

/* SCAN
error: expected a generic type name after 'where' in generic constraint, found '<:'
  ==> ref_type_in_generic_constrain_2.cj:10:31:
   | 
10 | interface Enumerable<U> where <: {}
   |                         ~~~~~ ^^ expected a generic type name here
   |                         |
   |                         after 'where' in generic constraint
   | 

error: expected type name after '<:', found '{'
  ==> ref_type_in_generic_constrain_2.cj:10:34:
   | 
10 | interface Enumerable<U> where <: {}
   |                               ~~ ^ expected type name here
   |                               |
   |                               after '<:'
   | 

2 errors generated, 2 errors printed.
*/
