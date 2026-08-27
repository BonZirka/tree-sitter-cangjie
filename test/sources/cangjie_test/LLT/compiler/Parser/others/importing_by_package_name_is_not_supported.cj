// DEPENDENCE: package_a.cj
// EXEC: %compiler %cmp_opt %compile_lib_opt package_a.cj -o package_a.%middle
// ERRCHECK:%compiler %cmp_opt %n.cj package_a.%middle 2>&1 | compare %f

import a
main():Unit{
    let b = x
}

/* SCAN
error: undeclared identifier 'x'
 ==> importing_by_package_name_is_not_supported.cj:7:13:
  | 
7 |     let b = x
  |             ^ 
  | 

warning: unused import 'a'
 ==> importing_by_package_name_is_not_supported.cj:5:1:
  | 
5 | import a
  | ^^^^^^^^ unused import
  | 
  # note: this warning can be suppressed by setting the compiler option `-Woff unused`

1 error generated, 1 error printed.
1 warning generated, 1 warning printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
