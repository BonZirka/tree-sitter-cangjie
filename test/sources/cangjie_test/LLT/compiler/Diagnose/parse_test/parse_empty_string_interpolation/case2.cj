// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

var a = "cj ${  } cj"

/* SCAN
error: string interpolation cannot be empty
  ==> case2.cj:10:13:
   | 
10 | var a = "cj ${  } cj"
   |             ^^^^^ empty string interpolation
   | 

1 error generated, 1 error printed.
*/
