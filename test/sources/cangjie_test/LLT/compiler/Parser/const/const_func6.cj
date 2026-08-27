// ERRCHECK: %compiler %f -o %output



struct A {
    let a = 0
    const init() {
    }
    const mut func f1(a: Int64) { // err
        return a
    }
    mut const func f2(a: Int64) { // err
        return a
    }
}

main() {}

/* SCAN
[31merror[0m: 'mut' and 'const' modifiers conflict on function declaration
 [36m==>[0m const_func6.cj:9:11:
  [36m| [0m
[36m9[0m [36m| [0m    const mut func f1(a: Int64) { // err[0m
  [36m| [0m    [36m~~~~~[0m [31m^^^[0m [36m~~~~ on function declaration[0m
  [36m| [0m    [36m|[0m     [31m|[0m
  [36m| [0m    [36m|[0m     [31munexpected modifier[0m
  [36m| [0m    [36m|[0m
  [36m| [0m    [36mbecause it is conflicted with this[0m
  [36m| [0m

[31merror[0m: 'const' and 'mut' modifiers conflict on function declaration
  [36m==>[0m const_func6.cj:12:9:
   [36m| [0m
[36m12[0m [36m| [0m    mut const func f2(a: Int64) { // err[0m
   [36m| [0m    [36m~~~[0m [31m^^^^^[0m [36m~~~~ on function declaration[0m
   [36m| [0m    [36m|[0m   [31m|[0m
   [36m| [0m    [36m|[0m   [31munexpected modifier[0m
   [36m| [0m    [36m|[0m
   [36m| [0m    [36mbecause it is conflicted with this[0m
   [36m| [0m

2 errors generated, 2 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
