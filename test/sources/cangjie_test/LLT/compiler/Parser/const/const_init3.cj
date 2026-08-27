// ERRCHECK: %compiler %cmp_opt %f -o %output

class AA{
    let name: String
    const private AA(
        name: String,                   // regular parameter
        annotation!: String = "anno",   // regular parameter
        let width!: Int64 = 1,          // member variable parameter with initial value
        private var length!: Int64,     // member variable parameter
        private var height!: Int64 = 3  // member variable parameter
    ) {
        this.name = name
    }
}

main() {}

/* SCAN
error: cannot define 'const' constructor with 'var' members in class
 ==> const_init3.cj:5:19:
  | 
5 |     const private AA(
  |                   ^^ 
  | 
note: member variable declared with 'var'
 ==> const_init3.cj:9:21:
  | 
9 |         private var length!: Int64,     // member variable parameter
  |                     ^^^^^^ 
  | 
note: member variable declared with 'var'
  ==> const_init3.cj:10:21:
   | 
10 |         private var height!: Int64 = 3  // member variable parameter
   |                     ^^^^^^ 
   | 

1 error generated, 1 error printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
