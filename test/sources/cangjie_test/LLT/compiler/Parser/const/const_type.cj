// ERRCHECK: %compiler %f -o %output

const public type a = test
public const type b = test

/* SCAN
[31merror[0m: unexpected modifier 'const' on type alias declaration
 [36m==>[0m const_type.cj:3:1:
  [36m| [0m
[36m3[0m [36m| [0mconst public type a = test[0m
  [36m| [0m[31m^^^^^[0m        [36m~~~~ on type alias declaration[0m
  [36m| [0m[31m|[0m
  [36m| [0m[31munexpected modifier[0m
  [36m| [0m

[31merror[0m: unexpected modifier 'const' on type alias declaration
 [36m==>[0m const_type.cj:4:8:
  [36m| [0m
[36m4[0m [36m| [0mpublic const type b = test[0m
  [36m| [0m       [31m^^^^^[0m [36m~~~~ on type alias declaration[0m
  [36m| [0m       [31m|[0m
  [36m| [0m       [31munexpected modifier[0m
  [36m| [0m

2 errors generated, 2 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
