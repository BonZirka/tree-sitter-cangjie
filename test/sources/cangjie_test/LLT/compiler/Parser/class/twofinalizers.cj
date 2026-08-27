// EXEC-PIPE-1: %compiler %f %compile_lib_opt --diagnostic-format=noColor 2>&1 | compare %f

class C {
    ~  init() {}
    ~ init() {}
}

/* SCAN-IN
error: function '~init' has overload conflicts
 ==> twofinalizers.cj:5:5:
  | 
5 |     ~ init() {}
  |     ^^^^^ 
  | 
note: conflict with the declaration
 ==> twofinalizers.cj:4:5:
  | 
4 |     ~  init() {}
  |     ^^^^^ 
  | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
