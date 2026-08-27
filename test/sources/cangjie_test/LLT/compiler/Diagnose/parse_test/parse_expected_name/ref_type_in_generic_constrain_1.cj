// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

interface Enumerable<U> where <: a {}

/* SCAN
error: expected a generic type name after 'where' in generic constraint, found '<:'
  ==> ref_type_in_generic_constrain_1.cj:10:31:
   | 
10 | interface Enumerable<U> where <: a {}
   |                         ~~~~~ ^^ expected a generic type name here
   |                         |
   |                         after 'where' in generic constraint
   | 

1 error generated, 1 error printed.
*/
