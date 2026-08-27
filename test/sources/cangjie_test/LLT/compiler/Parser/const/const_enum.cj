// ERRCHECK: %compiler %f -o %output

const enum E { // err
    e1
    const prop aa: Int64 {}  // err
}

main() {}

/* SCAN
[31merror[0m: unexpected modifier 'const' on enum declaration
 [36m==>[0m const_enum.cj:3:1:
  [36m| [0m
[36m3[0m [36m| [0mconst enum E { // err[0m
  [36m| [0m[31m^^^^^[0m [36m~~~~ on enum declaration[0m
  [36m| [0m[31m|[0m
  [36m| [0m[31munexpected modifier[0m
  [36m| [0m

[31merror[0m: unexpected modifier 'const' on property declaration in enum body
 [36m==>[0m const_enum.cj:5:5:
  [36m| [0m
[36m3[0m [36m| [0mconst enum E { // err[0m
  [36m| [0m      [36m~~~~ in enum[0m
[36m4[0m [36m| [0m    e1[0m
[36m5[0m [36m| [0m    const prop aa: Int64 {}  // err[0m
  [36m| [0m    [31m^^^^^[0m [36m~~~~ on property declaration[0m
  [36m| [0m    [31m|[0m
  [36m| [0m    [31munexpected modifier[0m
  [36m| [0m

2 errors generated, 2 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
