// ERRCHECK: %compiler %f -o %output

const class A {
    public const prop s: String {
        get() {
            return ""
        }
    }
}

/* SCAN
[31merror[0m: unexpected modifier 'const' on class declaration
 [36m==>[0m const_prop2.cj:3:1:
  [36m| [0m
[36m3[0m [36m| [0mconst class A {[0m
  [36m| [0m[31m^^^^^[0m [36m~~~~~ on class declaration[0m
  [36m| [0m[31m|[0m
  [36m| [0m[31munexpected modifier[0m
  [36m| [0m

[31merror[0m: unexpected modifier 'const' on property declaration in class body
 [36m==>[0m const_prop2.cj:4:12:
  [36m| [0m
[36m3[0m [36m| [0mconst class A {[0m
  [36m| [0m      [36m~~~~~ in class[0m
[36m4[0m [36m| [0m    public const prop s: String {[0m
  [36m| [0m           [31m^^^^^[0m [36m~~~~ on property declaration[0m
  [36m| [0m           [31m|[0m
  [36m| [0m           [31munexpected modifier[0m
  [36m| [0m

2 errors generated, 2 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
