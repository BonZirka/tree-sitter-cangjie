// ERRCHECK:%compiler %noColor %n.cj 2>&1 | compare %f

@When[os == "Linux"]
package A

/* SCAN
error: unexpected annotation '@When' on package
 ==> when_on_package_name_0.cj:3:1:
  | 
3 | @When[os == "Linux"]
  | ^^^^^^^^^^^^^^^^^^^^ unexpected annotation here
4 | package A
  | ~~~~~~~ on package
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
