// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

var a = {a!:Int64=>}

/* SCAN
error: expected one of ',', ':' or '=>', found '!'
  ==> double_arrow_in_lambda_1.cj:10:11:
   | 
10 | var a = {a!:Int64=>}
   |           ^ expected one of ',', ':' or '=>' here
   | 

1 error generated, 1 error printed.
*/
