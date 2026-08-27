// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

@When[backend == "cjna" + "tive"]
var a = 1

main() {}

/* SCAN
error: conditional compilation's condition value should be string literal without interpolation
  ==> macroExpandExpr.cj:10:18:
   | 
10 | @When[backend == "cjna" + "tive"]
   |                  ^ 
   | 

1 error generated, 1 error printed.
*/
