// ERRCHECK: %compiler %f -o %output

class AA{
    let name: String
    const private AA(
        name: String,                   // regular parameter
        annotation!: String = "anno",   // regular parameter
        const let width!: Int64 = 1,          // member variable parameter with initial value
        const private var length!: Int64,     // member variable parameter
        const private var height!: Int64 = 3  // member variable parameter
    ) {
        this.name = name
    }
}

main() {}

/* SCAN
[31merror[0m: unexpected modifier 'const' on var or let variable
 [36m==>[0m const_init6.cj:8:9:
  [36m| [0m
[36m8[0m [36m| [0m        const let width!: Int64 = 1,          // member variable parameter with initial value[0m
  [36m| [0m        [31m^^^^^[0m [36m~~~ [0m
  [36m| [0m        [31m|[0m
  [36m| [0m        [31munexpected modifier[0m
  [36m| [0m

[31merror[0m: unexpected modifier 'const' on var or let variable
 [36m==>[0m const_init6.cj:9:9:
  [36m| [0m
[36m9[0m [36m| [0m        const private var length!: Int64,     // member variable parameter[0m
  [36m| [0m        [31m^^^^^[0m         [36m~~~ [0m
  [36m| [0m        [31m|[0m
  [36m| [0m        [31munexpected modifier[0m
  [36m| [0m

[31merror[0m: unexpected modifier 'const' on var or let variable
  [36m==>[0m const_init6.cj:10:9:
   [36m| [0m
[36m10[0m [36m| [0m        const private var height!: Int64 = 3  // member variable parameter[0m
   [36m| [0m        [31m^^^^^[0m         [36m~~~ [0m
   [36m| [0m        [31m|[0m
   [36m| [0m        [31munexpected modifier[0m
   [36m| [0m

3 errors generated, 3 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
