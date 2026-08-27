// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

var a =  for(a )

/* SCAN
error: expected 'in' in for-in expression, found ')'
  ==> for_in_expr_1.cj:10:16:
   | 
10 | var a =  for(a )
   |                ^ expected 'in' here
   | 

1 error generated, 1 error printed.
*/
