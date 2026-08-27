// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

@When[os == "Linux"]
package A

/* SCAN
error: unexpected annotation '@When' on package
  ==> when_on_package_name_0.cj:10:1:
   | 
10 | @When[os == "Linux"]
   | ^^^^^^^^^^^^^^^^^^^^ unexpected annotation here
11 | package A
   | ~~~~~~~ on package
   | 

1 error generated, 1 error printed.
*/
