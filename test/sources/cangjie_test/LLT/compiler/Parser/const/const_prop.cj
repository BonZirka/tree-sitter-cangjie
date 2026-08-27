// ERRCHECK: %compiler %f -o %output

const struct A {
    mut const public prop s: String {
        get() {
            return ""
        }
    }
}

/* SCAN
[31merror[0m: unexpected modifier 'const' on struct declaration
 [36m==>[0m const_prop.cj:3:1:
  [36m| [0m
[36m3[0m [36m| [0mconst struct A {[0m
  [36m| [0m[31m^^^^^[0m [36m~~~~~~ on struct declaration[0m
  [36m| [0m[31m|[0m
  [36m| [0m[31munexpected modifier[0m
  [36m| [0m

[31merror[0m: unexpected modifier 'const' on property declaration in struct body
 [36m==>[0m const_prop.cj:4:9:
  [36m| [0m
[36m3[0m [36m| [0mconst struct A {[0m
  [36m| [0m      [36m~~~~~~ in struct[0m
[36m4[0m [36m| [0m    mut const public prop s: String {[0m
  [36m| [0m        [31m^^^^^[0m        [36m~~~~ on property declaration[0m
  [36m| [0m        [31m|[0m
  [36m| [0m        [31munexpected modifier[0m
  [36m| [0m

2 errors generated, 2 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
