// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

extend foo
{
    operator mut func f(){}
}

/* SCAN
error: cannot overload operator 'f' 
  ==> case25.cj:12:23:
   | 
12 |     operator mut func f(){}
   |                       ^ cannot overload this operator
   | 
   # note: only operator '+', '-', ... can be overloaded

1 error generated, 1 error printed.
*/
