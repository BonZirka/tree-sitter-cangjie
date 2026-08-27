// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output

class AA{
    let name: String
    const AA(
        const name: String,                  // regular parameter
        const annotation!: String = "anno"   // regular parameter
    ) {
        this.name = name
    }
}

main() {}

/* SCAN
error: unexpected const member variable declaration in primary constructor paramlist
 ==> const_init4.cj:7:9:
  | 
7 |         const name: String,                  // regular parameter
  |         ^^^^^ unexpected const member variable declaration
  | 

error: unexpected const member variable declaration in primary constructor paramlist
 ==> const_init4.cj:8:9:
  | 
8 |         const annotation!: String = "anno"   // regular parameter
  |         ^^^^^ unexpected const member variable declaration
  | 

2 errors generated, 2 errors printed.
*/

// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
