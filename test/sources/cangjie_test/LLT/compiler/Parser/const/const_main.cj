// ERRCHECK: %compiler %f -o %output

const public a = 1

const main() {
    const static b = 2
    const c = 1
}

/* SCAN
[31merror[0m: expected declaration, found 'a'
 [36m==>[0m const_main.cj:3:14:
  [36m| [0m
[36m3[0m [36m| [0mconst public a = 1[0m
  [36m| [0m             [31m^ expected declaration here[0m
  [36m| [0m
  [36m#[0m [0mnote[0m: only declarations or macro expressions can be used in the top-level

[31merror[0m: unexpected modifier 'const' on main function
 [36m==>[0m const_main.cj:5:1:
  [36m| [0m
[36m5[0m [36m| [0mconst main() {[0m
  [36m| [0m[31m^^^^^[0m [36m~~~~ on main function[0m
  [36m| [0m[31m|[0m
  [36m| [0m[31munexpected modifier[0m
  [36m| [0m

[31merror[0m: expected declaration, found 'b'
 [36m==>[0m const_main.cj:6:18:
  [36m| [0m
[36m6[0m [36m| [0m    const static b = 2[0m
  [36m| [0m                 [31m^ expected declaration here[0m
  [36m| [0m

3 errors generated, 3 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
